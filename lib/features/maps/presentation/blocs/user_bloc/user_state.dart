part of 'user_bloc.dart';

 class UserState extends Equatable {
  final TerrainEnum gravel;
  final StairsEnum stairs;
  final TerrainEnum sand;

  const UserState({required this.gravel, required this.stairs, required this.sand});

  @override
  List<Object> get props => [gravel, sand, stairs];

  UserState copyWith({TerrainEnum? gravel, StairsEnum? stairs, TerrainEnum? sand}) {
    return UserState(
      sand: sand ?? this.sand,
      stairs: stairs ?? this.stairs,
      gravel: gravel ?? this.gravel,
    );
  }
}

