// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../../application/logger/i_logger.dart';
import '../service/i_supplier_service.dart';

part 'supplier_controller.g.dart';

@Injectable()
class SupplierController {
  final ISupplierService service;
  final ILogger log;

  SupplierController({
    required this.service,
    required this.log,
  });

  @Route.get('/')
  Future<Response> findNearByMe(Request request) async {
    try {
      final lat = double.tryParse(request.url.queryParameters['lat'] ?? '');
      final lng = double.tryParse(request.url.queryParameters['lng'] ?? '');

      if (lat == null || lng == null) {
        return Response(
          400,
          body: jsonEncode(
            {'message': 'Latitude e Longitude obrigatórios'},
          ),
        );
      }

      final suppliers = await service.findNearMeBy(lat, lng);

      final result = suppliers
          .map((s) => {
                'id': s.id,
                'name': s.name,
                'logo': s.logo,
                'distance': s.distance,
                'category': s.categoryId,
              })
          .toList();

      return Response.ok(jsonEncode(result));
    } catch (e, s) {
      log.error('Erro ao buscar fornecedores perto de mim', e, s);
      return Response.internalServerError(
        body: jsonEncode(
          {
            'message': 'Erro ao buscar fornecedores perto de mim',
          },
        ),
      );
    }
  }

  Router get router => _$SupplierControllerRouter(this);
}
