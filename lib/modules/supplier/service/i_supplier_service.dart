import '../../../dtos/supplier_near_by_me_dto.dart';
import '../../../entities/supplier.dart';

abstract class ISupplierService {
  Future<List<SupplierNearByMeDto>> findNearMeBy(double lat, double lng);
  Future<Supplier?> findById(int id);
}
