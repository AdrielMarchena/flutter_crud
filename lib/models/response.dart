enum StatusCode { ok, internalError }

class Response {
  int? code;
  String? message;
  Response({this.code, this.message});
}
