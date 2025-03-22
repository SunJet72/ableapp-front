import 'package:able_app/features/maps/domain/entities/path.dart';
import 'package:equatable/equatable.dart';

class Way extends Equatable {
  final List<Path> paths;
  final double distance;
  final int duration;

  const Way({
    required this.duration,
    required this.paths,
    required this.distance,
  });

  @override
  List<Object?> get props => [paths, distance];
}
