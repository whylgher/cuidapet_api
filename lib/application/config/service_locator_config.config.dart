// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cuidapet_api/application/config/database_connection_configuration.dart'
    as _i9;
import 'package:cuidapet_api/application/database/i_database_connection.dart'
    as _i7;
import 'package:cuidapet_api/application/database/i_database_connection_impl.dart'
    as _i8;
import 'package:cuidapet_api/application/logger/i_logger.dart' as _i12;
import 'package:cuidapet_api/modules/categories/controller/categories_controller.dart'
    as _i31;
import 'package:cuidapet_api/modules/categories/data/i_categories_repository.dart'
    as _i24;
import 'package:cuidapet_api/modules/categories/data/i_categories_repository_impl.dart'
    as _i25;
import 'package:cuidapet_api/modules/categories/service/i_categories_service.dart'
    as _i26;
import 'package:cuidapet_api/modules/categories/service/i_categories_service_impl.dart'
    as _i27;
import 'package:cuidapet_api/modules/chat/data/i_chat_repository.dart' as _i3;
import 'package:cuidapet_api/modules/chat/data/i_chat_repository_impl.dart'
    as _i4;
import 'package:cuidapet_api/modules/chat/service/i_chat_service.dart' as _i5;
import 'package:cuidapet_api/modules/chat/service/i_chat_service_impl.dart'
    as _i6;
import 'package:cuidapet_api/modules/schedules/controller/schedule_controller.dart'
    as _i21;
import 'package:cuidapet_api/modules/schedules/data/i_schedule_repository.dart'
    as _i10;
import 'package:cuidapet_api/modules/schedules/data/i_schedule_repository_impl.dart'
    as _i11;
import 'package:cuidapet_api/modules/schedules/service/i_schedule_service.dart'
    as _i13;
import 'package:cuidapet_api/modules/schedules/service/i_schedule_service_impl.dart'
    as _i14;
import 'package:cuidapet_api/modules/supplier/controller/supplier_controller.dart'
    as _i30;
import 'package:cuidapet_api/modules/supplier/data/i_supplier_repository.dart'
    as _i15;
import 'package:cuidapet_api/modules/supplier/data/i_supplier_repository_impl.dart'
    as _i16;
import 'package:cuidapet_api/modules/supplier/service/i_supplier_service.dart'
    as _i28;
import 'package:cuidapet_api/modules/supplier/service/i_supplier_service_impl.dart'
    as _i29;
import 'package:cuidapet_api/modules/user/controller/auth_controller.dart'
    as _i23;
import 'package:cuidapet_api/modules/user/controller/user_controller.dart'
    as _i22;
import 'package:cuidapet_api/modules/user/data/i_user_repository.dart' as _i17;
import 'package:cuidapet_api/modules/user/data/i_user_repository_impl.dart'
    as _i18;
import 'package:cuidapet_api/modules/user/service/i_user_service.dart' as _i19;
import 'package:cuidapet_api/modules/user/service/i_user_service_impl.dart'
    as _i20;
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
  gh.lazySingleton<_i3.IChatRepository>(() => _i4.IChatRepositoryImpl());
  gh.lazySingleton<_i5.IChatService>(() => _i6.IChatServiceImpl());
  gh.lazySingleton<_i7.IDatabaseConnection>(() =>
      _i8.IDatabaseConnectionImpl(gh<_i9.DatabaseConnectionConfiguration>()));
  gh.lazySingleton<_i10.IScheduleRepository>(() => _i11.IScheduleRepositoryImpl(
        connection: gh<_i7.IDatabaseConnection>(),
        log: gh<_i12.ILogger>(),
      ));
  gh.lazySingleton<_i13.IScheduleService>(() =>
      _i14.IScheduleServiceImpl(repository: gh<_i10.IScheduleRepository>()));
  gh.lazySingleton<_i15.ISupplierRepository>(() => _i16.ISupplierRepositoryImpl(
        connection: gh<_i7.IDatabaseConnection>(),
        log: gh<_i12.ILogger>(),
      ));
  gh.lazySingleton<_i17.IUserRepository>(() => _i18.IUserRepositoryImpl(
        connection: gh<_i7.IDatabaseConnection>(),
        log: gh<_i12.ILogger>(),
      ));
  gh.lazySingleton<_i19.IUserService>(() => _i20.IUserServiceImpl(
        userRepository: gh<_i17.IUserRepository>(),
        log: gh<_i12.ILogger>(),
      ));
  gh.factory<_i21.ScheduleController>(() => _i21.ScheduleController(
        service: gh<_i13.IScheduleService>(),
        log: gh<_i12.ILogger>(),
      ));
  gh.factory<_i22.UserController>(() => _i22.UserController(
        userService: gh<_i19.IUserService>(),
        log: gh<_i12.ILogger>(),
      ));
  gh.factory<_i23.AuthController>(() => _i23.AuthController(
        userService: gh<_i19.IUserService>(),
        log: gh<_i12.ILogger>(),
      ));
  gh.lazySingleton<_i24.ICategoriesRepository>(
      () => _i25.ICategoriesRepositoryImpl(
            connection: gh<_i7.IDatabaseConnection>(),
            log: gh<_i12.ILogger>(),
          ));
  gh.lazySingleton<_i26.ICategoriesService>(() => _i27.ICategoriesServiceImpl(
      repository: gh<_i24.ICategoriesRepository>()));
  gh.lazySingleton<_i28.ISupplierService>(() => _i29.ISupplierServiceImpl(
        userService: gh<_i19.IUserService>(),
        repository: gh<_i15.ISupplierRepository>(),
      ));
  gh.factory<_i30.SupplierController>(() => _i30.SupplierController(
        service: gh<_i28.ISupplierService>(),
        log: gh<_i12.ILogger>(),
      ));
  gh.factory<_i31.CategoriesController>(
      () => _i31.CategoriesController(service: gh<_i26.ICategoriesService>()));
  return getIt;
}
