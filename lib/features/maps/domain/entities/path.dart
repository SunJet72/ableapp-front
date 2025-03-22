import 'package:able_app/config/enums/terrain_enum.dart';
import 'package:able_app/config/enums/terrain_type.dart';
import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

class Path extends Equatable {
  final List<LatLng> points;
  final Duration duration;
  final TerrainType terrain;

  const Path({
    required this.points,
    required this.duration,
    required this.terrain,
  });

  @override
  List<Object?> get props => [points, duration, terrain];
}
