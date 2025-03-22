part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();
}

final class ChangeGravelEvent extends UserEvent {
  final TerrainEnum gravel;

  const ChangeGravelEvent({required this.gravel});

  @override
  List<Object?> get props => [gravel];
}


final class ChangeSandEvent extends UserEvent {
  final TerrainEnum sand;

  const ChangeSandEvent({required this.sand});

  @override
  List<Object?> get props => [sand];
}

final class ChangeStairsEvent extends UserEvent {
  final StairsEnum stairs;

  const ChangeStairsEvent({required this.stairs});

  @override
  List<Object?> get props => [stairs];
}
