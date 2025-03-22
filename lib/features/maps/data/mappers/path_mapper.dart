import 'package:able_app/config/enums/terrain_enum.dart';
import 'package:able_app/config/enums/terrain_type.dart';
import 'package:able_app/features/maps/data/models/path_model.dart';

import '../../domain/entities/path.dart';

class PathMapper {
  const PathMapper._();

  static Path toEntity(PathModel model) {
    return Path(
      points: model.points,
      duration: Duration(milliseconds: model.duration),
      terrain: TerrainType.values[model.terrain],
    );
  }

  static PathModel toModel(Path entity) {
    return PathModel(
      points: entity.points,
      terrain: entity.terrain.index,
      duration: entity.duration.inMilliseconds,
    );
  }
}
