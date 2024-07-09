class Success {
  final Object data;
  final dynamic message;
  final dynamic code;

  Success({required this.data, this.message, this.code});
}

class Failure {
  final dynamic message;
  final dynamic code;

  Failure({this.message, this.code});
}
