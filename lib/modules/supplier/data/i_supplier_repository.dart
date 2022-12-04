import '../../../dtos/supplier_near_by_me_dto.dart';

abstract class ISupplierRepository {
  Future<List<SupplierNearByMeDto>> findNearByPosition(
      double lat, double lng, int distance);
}
