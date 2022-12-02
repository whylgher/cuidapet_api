import '../../../entities/user.dart';

abstract class IUserRepository {
  Future<User> createUser(User user);
  Future<User> loginWithEmailPassword(
      String email, String password, bool supplier);
  Future<User> loginByEmailSocialKey(
      String email, String socialKey, String socialType);
}