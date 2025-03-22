import 'package:able_app/config/enums/stairs_enum.dart';
import 'package:able_app/config/enums/terrain_enum.dart';
import 'package:able_app/core/datasource/data_state.dart';
import 'package:able_app/features/maps/domain/entities/way.dart';
import 'package:latlong2/latlong.dart';

abstract class RouteRepository {
  Future<DataState<Way>> buildRoute(
    LatLng start,
    LatLng end,
    TerrainEnum sandState,
    StairsEnum stairsCount,
    TerrainEnum gravelState,
  );
}
