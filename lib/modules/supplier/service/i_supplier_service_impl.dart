// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cuidapet_api/dtos/supplier_near_by_me_dto.dart';
import 'package:cuidapet_api/entities/supplier.dart';
import 'package:injectable/injectable.dart';

import './i_supplier_service.dart';
import '../data/i_supplier_repository.dart';

@LazySingleton(as: ISupplierService)
class ISupplierServiceImpl implements ISupplierService {
  final ISupplierRepository repository;
  static const DISTANCE = 5;

  ISupplierServiceImpl({
    required this.repository,
  });

  @override
  Future<List<SupplierNearByMeDto>> findNearMeBy(double lat, double lng) =>
      repository.findNearByPosition(lat, lng, DISTANCE);

  @override
  Future<Supplier?> findById(int id) => repository.findById(id);
}
