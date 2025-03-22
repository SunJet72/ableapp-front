import 'package:able_app/config/enums/stairs_enum.dart';
import 'package:able_app/config/enums/terrain_enum.dart';
import 'package:able_app/core/datasource/data_state.dart';
import 'package:able_app/core/usecase/usecase.dart';
import 'package:able_app/features/maps/domain/entities/way.dart';
import 'package:able_app/features/maps/domain/repositories/route_repository.dart';
import 'package:latlong2/latlong.dart';

class BuildRouteUsecase
    implements Usecase<Future<DataState<Way>>, BuildRouteUsecaseParam> {
  final RouteRepository repository;

  const BuildRouteUsecase({required this.repository});

  @override
  Future<DataState<Way>> call({required BuildRouteUsecaseParam param}) async {
    return await repository.buildRoute(
      param.start,
      param.end,
      param.sandState,
      param.stairsCount,
      param.gravelState,
    );
  }
}

interface class BuildRouteUsecaseParam {
  final LatLng start;
  final LatLng end;
  final TerrainEnum sandState;
  final TerrainEnum gravelState;
  final StairsEnum stairsCount;

  const BuildRouteUsecaseParam({
    required this.start,
    required this.end,
    required this.sandState,
    required this.gravelState,
    required this.stairsCount,
  });
}
