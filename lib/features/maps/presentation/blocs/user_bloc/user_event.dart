part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();
}

final class ChangeTerrainEvent extends UserEvent {
  final TerrainEnum terrain;

  const ChangeTerrainEvent({required this.terrain});

  @override
  List<Object?> get props => [terrain];
}

final class ChangeStairsEvent extends UserEvent {
  final StairsEnum stairs;

  const ChangeStairsEvent({required this.stairs});

  @override
  List<Object?> get props => [stairs];
}
