// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'category.dart';

class Supplier {
  final int? id;
  final String? name;
  final String? logo;
  final String? address;
  final String? phone;
  final double? lat;
  final double? lng;
  final Category? category;

  Supplier({
    this.id,
    this.name,
    this.logo,
    this.address,
    this.phone,
    this.lat,
    this.lng,
    this.category,
  });
}
