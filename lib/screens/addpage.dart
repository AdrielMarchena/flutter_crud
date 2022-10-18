import 'package:beg_app/screens/listpage.dart';
import 'package:beg_app/extensions/response_extensions.dart';
import 'package:flutter/material.dart';

import '../services/firebase_crud.dart';

class AddPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddPage();
  }
}

class _AddPage extends State<AddPage> {
  final _employee_name = TextEditingController();
  final _employee_position = TextEditingController();
  final _employee_contact = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void saveButtonOnPressed(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    var response = await FirebaseCrud.addEmployee(
        name: _employee_name.text,
        position: _employee_position.text,
        contactno: _employee_contact.text);

    if (!response.isOk) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(response.message.toString()),
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(response.message.toString()),
            );
          });
    }
  }

  TextFormField createField({
    required String hint,
    required TextEditingController controller,
  }) =>
      TextFormField(
        controller: controller,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final nameField = createField(hint: "Name", controller: _employee_name);

    final positionField =
        createField(hint: "Position", controller: _employee_position);

    final contactField =
        createField(hint: "Contact Number", controller: _employee_contact);

    final viewListbutton = TextButton(
      onPressed: () {
        Navigator.pushAndRemoveUntil<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => ListPage(),
          ),
          (route) => false,
        );
      },
      child: const Text('View List of Employee'),
    );

    final saveButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: () async => saveButtonOnPressed(context),
          child: Text(
            "Save",
            style: TextStyle(color: Theme.of(context).primaryColorLight),
            textAlign: TextAlign.center,
          )),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('FreeCode Spot'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  nameField,
                  const SizedBox(height: 25.0),
                  positionField,
                  const SizedBox(height: 35.0),
                  contactField,
                  viewListbutton,
                  const SizedBox(height: 45.0),
                  saveButton,
                  const SizedBox(height: 15.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
