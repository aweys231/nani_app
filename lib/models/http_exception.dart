// ignore_for_file: camel_case_types

class HttpException implements Exception {
  final String message;
  HttpException(this.message);
  @override
  String toString() {
    return message;
    // return super.toString();
  }
}
