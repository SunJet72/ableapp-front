import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

class PathModel extends Equatable {
  final List<LatLng> points;
  final int terrain;
  final int duration;

  const PathModel({
    required this.points,
    required this.terrain,
    required this.duration,
  });

  factory PathModel.fromJson(Map<String, dynamic> json) {
    return PathModel(
      points: List<LatLng>.from(
        json['points'].map((x) => LatLng(x['lat'], x['lon'])),
      ),
      terrain: json['terrain'],
      duration: json['duration'],
    );
  }

  List<PathModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => PathModel.fromJson(json)).toList();
  }

  @override
  List<Object?> get props => [points, terrain, duration];
}
