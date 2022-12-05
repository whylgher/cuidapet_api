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
import 'package:cuidapet_api/application/logger/i_logger.dart' as _i12;
import 'package:cuidapet_api/modules/categories/controller/categories_controller.dart'
    as _i27;
import 'package:cuidapet_api/modules/categories/data/i_categories_repository.dart'
    as _i20;
import 'package:cuidapet_api/modules/categories/data/i_categories_repository_impl.dart'
    as _i21;
import 'package:cuidapet_api/modules/categories/service/i_categories_service.dart'
    as _i22;
import 'package:cuidapet_api/modules/categories/service/i_categories_service_impl.dart'
    as _i23;
import 'package:cuidapet_api/modules/schedules/controller/schedule_controller.dart'
    as _i17;
import 'package:cuidapet_api/modules/schedules/data/i_schedule_repository.dart'
    as _i6;
import 'package:cuidapet_api/modules/schedules/data/i_schedule_repository_impl.dart'
    as _i7;
import 'package:cuidapet_api/modules/schedules/service/i_schedule_service.dart'
    as _i8;
import 'package:cuidapet_api/modules/schedules/service/i_schedule_service_impl.dart'
    as _i9;
import 'package:cuidapet_api/modules/supplier/controller/supplier_controller.dart'
    as _i26;
import 'package:cuidapet_api/modules/supplier/data/i_supplier_repository.dart'
    as _i10;
import 'package:cuidapet_api/modules/supplier/data/i_supplier_repository_impl.dart'
    as _i11;
import 'package:cuidapet_api/modules/supplier/service/i_supplier_service.dart'
    as _i24;
import 'package:cuidapet_api/modules/supplier/service/i_supplier_service_impl.dart'
    as _i25;
import 'package:cuidapet_api/modules/user/controller/auth_controller.dart'
    as _i19;
import 'package:cuidapet_api/modules/user/controller/user_controller.dart'
    as _i18;
import 'package:cuidapet_api/modules/user/data/i_user_repository.dart' as _i13;
import 'package:cuidapet_api/modules/user/data/i_user_repository_impl.dart'
    as _i14;
import 'package:cuidapet_api/modules/user/service/i_user_service.dart' as _i15;
import 'package:cuidapet_api/modules/user/service/i_user_service_impl.dart'
    as _i16;
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
  gh.lazySingleton<_i6.IScheduleRepository>(
      () => _i7.IScheduleRepositoryImpl());
  gh.lazySingleton<_i8.IScheduleService>(() => _i9.IScheduleServiceImpl());
  gh.lazySingleton<_i10.ISupplierRepository>(() => _i11.ISupplierRepositoryImpl(
        connection: gh<_i3.IDatabaseConnection>(),
        log: gh<_i12.ILogger>(),
      ));
  gh.lazySingleton<_i13.IUserRepository>(() => _i14.IUserRepositoryImpl(
        connection: gh<_i3.IDatabaseConnection>(),
        log: gh<_i12.ILogger>(),
      ));
  gh.lazySingleton<_i15.IUserService>(() => _i16.IUserServiceImpl(
        userRepository: gh<_i13.IUserRepository>(),
        log: gh<_i12.ILogger>(),
      ));
  gh.factory<_i17.ScheduleController>(() => _i17.ScheduleController());
  gh.factory<_i18.UserController>(() => _i18.UserController(
        userService: gh<_i15.IUserService>(),
        log: gh<_i12.ILogger>(),
      ));
  gh.factory<_i19.AuthController>(() => _i19.AuthController(
        userService: gh<_i15.IUserService>(),
        log: gh<_i12.ILogger>(),
      ));
  gh.lazySingleton<_i20.ICategoriesRepository>(
      () => _i21.ICategoriesRepositoryImpl(
            connection: gh<_i3.IDatabaseConnection>(),
            log: gh<_i12.ILogger>(),
          ));
  gh.lazySingleton<_i22.ICategoriesService>(() => _i23.ICategoriesServiceImpl(
      repository: gh<_i20.ICategoriesRepository>()));
  gh.lazySingleton<_i24.ISupplierService>(() => _i25.ISupplierServiceImpl(
        userService: gh<_i15.IUserService>(),
        repository: gh<_i10.ISupplierRepository>(),
      ));
  gh.factory<_i26.SupplierController>(() => _i26.SupplierController(
        service: gh<_i24.ISupplierService>(),
        log: gh<_i12.ILogger>(),
      ));
  gh.factory<_i27.CategoriesController>(
      () => _i27.CategoriesController(service: gh<_i22.ICategoriesService>()));
  return getIt;
}
