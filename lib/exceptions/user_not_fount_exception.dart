// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserNotFountException implements Exception {
  String message;

  UserNotFountException({
    required this.message,
  });
}
