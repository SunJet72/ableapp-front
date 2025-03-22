part of 'route_bloc.dart';

sealed class RouteEvent extends Equatable {
  const RouteEvent();
}

class BuildRouteEvent extends RouteEvent {
  final StairsEnum stairs;
  final TerrainEnum gravel;
  final TerrainEnum sand;
  final LatLng start;
  final LatLng end;

  const BuildRouteEvent({
    required this.stairs,
    required this.gravel,
    required this.sand,
    required this.start,
    required this.end,
  });

  @override
  List<Object?> get props => [stairs, gravel, sand, start, end];
}
