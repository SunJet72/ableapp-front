import 'package:able_app/features/maps/data/mappers/path_mapper.dart';
import 'package:able_app/features/maps/data/models/way_model.dart';
import 'package:able_app/features/maps/domain/entities/way.dart';

class WayMapper {
  const WayMapper._();

  static Way toEntity(WayModel model) {
    return Way(
      paths:
          model.paths.map((e) => PathMapper.toEntity(e)).toList(),
      distance: model.distance,
    );
  }

  static WayModel toModel(Way entity) {
    return WayModel(
      paths: entity.paths.map((e) => PathMapper.toModel(e)).toList(),
      distance: entity.distance,
    );
  }
}
