import 'package:able_app/features/maps/data/models/path_model.dart';
import 'package:equatable/equatable.dart';

class WayModel extends Equatable {
  final List<PathModel> paths;
  final double distance;
  final int duration;

  const WayModel({
    required this.duration,
    required this.paths,
    required this.distance,
  });

  factory WayModel.fromJson(Map<String, dynamic> json) {
    return WayModel(
      duration: json['duration'],
      paths: List<PathModel>.from(
        json['paths'].map((x) => PathModel.fromJson(x)),
      ),
      distance: json['distance'],
    );
  }

  @override
  List<Object?> get props => [paths, distance];
}
