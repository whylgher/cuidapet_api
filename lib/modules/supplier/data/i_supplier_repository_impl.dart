import 'package:injectable/injectable.dart';

import './i_supplier_repository.dart';

@LazySingleton(as: ISupplierRepositoryImpl)
class ISupplierRepositoryImpl implements ISupplierRepository {}
