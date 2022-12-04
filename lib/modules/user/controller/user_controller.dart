// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';

import 'package:cuidapet_api/exceptions/user_not_found_exception.dart';
import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../../application/logger/i_logger.dart';
import '../service/i_user_service.dart';

part 'user_controller.g.dart';

@Injectable()
class UserController {
  IUserService userService;
  ILogger log;

  UserController({
    required this.userService,
    required this.log,
  });

  @Route.get('/')
  Future<Response> findByToken(Request request) async {
    try {
      final user = int.parse(request.headers['user']!);
      final userData = await userService.findById(user);

      return Response.ok(jsonEncode({
        'email': userData.email,
        'register_type': userData.registerType,
        'img_avatar': userData.imageAvatar
      }));
    } on UserNotFoundException catch (e) {
      return Response(
        204,
      );
    } catch (e, s) {
      log.error('Erro ao buscar usuário', e, s);

      return Response.internalServerError(
        body: jsonEncode(
          {
            'message': 'Erro ao buscar usuário.',
          },
        ),
      );
    }
  }

  Router get router => _$UserControllerRouter(this);
}
