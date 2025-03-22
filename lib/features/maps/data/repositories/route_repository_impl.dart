import 'dart:convert';

import 'package:able_app/config/enums/stairs_enum.dart';
import 'package:able_app/config/enums/terrain_enum.dart';
import 'package:able_app/core/datasource/data_state.dart';
import 'package:able_app/features/maps/data/mappers/way_mapper.dart';
import 'package:able_app/features/maps/data/models/way_model.dart';
import 'package:able_app/features/maps/domain/entities/way.dart';
import 'package:able_app/features/maps/domain/repositories/route_repository.dart';
import 'package:http/http.dart';
import 'package:latlong2/latlong.dart';

class RouteRepositoryImpl implements RouteRepository {
  final Client client;

  const RouteRepositoryImpl({required this.client});

  static const String _baseUrl = 'https://ableapp.sunjet-project.de';
  final String _routePath = '$_baseUrl/api/route';

  @override
  Future<DataState<Way>> buildRoute(
    LatLng start,
    LatLng end,
    TerrainEnum sandState,
    StairsEnum stairsCount,
    TerrainEnum gravelState,
  ) async {
    final url = Uri.parse(_routePath);
    final response = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'sendState': sandState.index,
        'stairsCount': stairsCount.index,
        'gravelState': gravelState.index,
        'start': {'lat': start.latitude, 'lon': start.longitude},
        'end': {'lat': end.latitude, 'lon': end.longitude},
      }),
    );
    print(response.request?.url);
    print(jsonEncode({
      'sendState': sandState.index,
      'stairsCount': stairsCount.index,
      'gravelState': gravelState.index,
      'start': {'lat': start.latitude, 'lon': start.longitude},
      'end': {'lat': end.latitude, 'lon': end.longitude},
    }),);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return DataSuccess<Way>(
        WayMapper.toEntity(WayModel.fromJson(jsonDecode(response.body))),
      );
    } else {
      return DataFailure<Way>(response.body);
    }
  }
}
