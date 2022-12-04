import '../../../dtos/supplier_near_by_me_dto.dart';

abstract class ISupplierService {
  Future<List<SupplierNearByMeDto>> findNearMeBy(double lat, double lng);
}
