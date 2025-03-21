part of 'user_bloc.dart';

 class UserState extends Equatable {
  final TerrainEnum terrain;
  final StairsEnum stairs;

  const UserState({required this.terrain, required this.stairs});

  @override
  List<Object> get props => [terrain, stairs];

  UserState copyWith({TerrainEnum? terrain, StairsEnum? stairs}) {
    return UserState(
      terrain: terrain ?? this.terrain,
      stairs: stairs ?? this.stairs,
    );
  }
}

