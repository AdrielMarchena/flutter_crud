import 'package:beg_app/models/response.dart';

// Not necessary, just exploring dart extensions
extension ResponseExtensions on Response {
  bool get isOk => isStatusCode(StatusCode.ok);
  bool get isInternalError => isStatusCode(StatusCode.internalError);

  bool isStatusCode(StatusCode statusCode) => isCode(statusCode.code);
  bool isCode(int code) => this.code == code;
}

extension StatusCodeExtensions on StatusCode {
  int get code {
    switch (this) {
      case StatusCode.ok:
        return 200;
      case StatusCode.internalError:
        return 500;
    }
  }
}
