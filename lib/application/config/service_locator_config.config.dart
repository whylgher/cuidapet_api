// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cuidapet_api/application/config/database_connection_configuration.dart'
    as _i5;
import 'package:cuidapet_api/application/database/i_database_connection.dart'
    as _i3;
import 'package:cuidapet_api/application/database/i_database_connection_impl.dart'
    as _i4;
import 'package:cuidapet_api/application/logger/i_logger.dart' as _i8;
import 'package:cuidapet_api/modules/categories/controller/categories_controller.dart'
    as _i17;
import 'package:cuidapet_api/modules/categories/data/i_categories_repository.dart'
    as _i13;
import 'package:cuidapet_api/modules/categories/data/i_categories_repository_impl.dart'
    as _i14;
import 'package:cuidapet_api/modules/categories/service/i_categories_service.dart'
    as _i15;
import 'package:cuidapet_api/modules/categories/service/i_categories_service_impl.dart'
    as _i16;
import 'package:cuidapet_api/modules/user/controller/auth_controller.dart'
    as _i12;
import 'package:cuidapet_api/modules/user/controller/user_controller.dart'
    as _i11;
import 'package:cuidapet_api/modules/user/data/i_user_repository.dart' as _i6;
import 'package:cuidapet_api/modules/user/data/i_user_repository_impl.dart'
    as _i7;
import 'package:cuidapet_api/modules/user/service/i_user_service.dart' as _i9;
import 'package:cuidapet_api/modules/user/service/i_user_service_impl.dart'
    as _i10;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of main-scope dependencies inside of [GetIt]
_i1.GetIt init(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.lazySingleton<_i3.IDatabaseConnection>(() =>
      _i4.IDatabaseConnectionImpl(gh<_i5.DatabaseConnectionConfiguration>()));
  gh.lazySingleton<_i6.IUserRepository>(() => _i7.IUserRepositoryImpl(
        connection: gh<_i3.IDatabaseConnection>(),
        log: gh<_i8.ILogger>(),
      ));
  gh.lazySingleton<_i9.IUserService>(() => _i10.IUserServiceImpl(
        userRepository: gh<_i6.IUserRepository>(),
        log: gh<_i8.ILogger>(),
      ));
  gh.factory<_i11.UserController>(() => _i11.UserController(
        userService: gh<_i9.IUserService>(),
        log: gh<_i8.ILogger>(),
      ));
  gh.factory<_i12.AuthController>(() => _i12.AuthController(
        userService: gh<_i9.IUserService>(),
        log: gh<_i8.ILogger>(),
      ));
  gh.lazySingleton<_i13.ICategoriesRepository>(
      () => _i14.ICategoriesRepositoryImpl(
            connection: gh<_i3.IDatabaseConnection>(),
            log: gh<_i8.ILogger>(),
          ));
  gh.lazySingleton<_i15.ICategoriesService>(() => _i16.ICategoriesServiceImpl(
      repository: gh<_i13.ICategoriesRepository>()));
  gh.factory<_i17.CategoriesController>(
      () => _i17.CategoriesController(service: gh<_i15.ICategoriesService>()));
  return getIt;
}
