// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:injectable/injectable.dart';

import './i_user_service.dart';
import '../../../application/logger/i_logger.dart';
import '../../../entities/user.dart';
import '../../../exceptions/user_not_found_exception.dart';
import '../data/i_user_repository.dart';
import '../view_models/user_save_input_model.dart';

@LazySingleton(as: IUserService)
class IUserServiceImpl implements IUserService {
  IUserRepository userRepository;
  ILogger log;

  IUserServiceImpl({
    required this.userRepository,
    required this.log,
  });

  @override
  Future<User> createUser(UserSaveInputModel user) {
    final userEntity = User(
        email: user.email,
        password: user.password,
        registerType: 'App',
        supplierId: user.supplierId);

    return userRepository.createUser(userEntity);
  }

  @override
  Future<User> loginWithEmailPassword(
          String email, String password, bool supplier) =>
      userRepository.loginWithEmailPassword(email, password, supplier);

  @override
  Future<User> loginWithSocial(
      String email, String avatar, String socialType, String socialKey) async {
    try {
      return await userRepository.loginByEmailSocialKey(
          email, socialKey, socialType);
    } on UserNotFoundException catch (e) {
      log.error('Usuário não encontrado, criando um usuário', e);

      final user = User(
        email: email,
        imageAvatar: avatar,
        registerType: socialType,
        socialKey: socialKey,
        password: DateTime.now().toString(),
      );

      return await userRepository.createUser(user);
    }
  }
}
