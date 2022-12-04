import '../../../dtos/supplier_near_by_me_dto.dart';
import '../../../entities/supplier.dart';

abstract class ISupplierRepository {
  Future<List<SupplierNearByMeDto>> findNearByPosition(
      double lat, double lng, int distance);
  Future<Supplier> findById(int id);
}
