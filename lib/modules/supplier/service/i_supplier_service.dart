import '../../../dtos/supplier_near_by_me_dto.dart';
import '../../../entities/supplier.dart';
import '../../../entities/supplier_service.dart';

abstract class ISupplierService {
  Future<List<SupplierNearByMeDto>> findNearMeBy(double lat, double lng);
  Future<Supplier?> findById(int id);
  Future<List<SupplierService>> findServicesSupplier(int supplierId);
}
