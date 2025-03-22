part of 'route_bloc.dart';

sealed class RouteState extends Equatable {
  const RouteState();
}

final class RouteInitial extends RouteState {
  @override
  List<Object> get props => [];
}

final class RouteLoading extends RouteState {
  const RouteLoading();

  @override
  List<Object> get props => [];
}

final class RouteLoaded extends RouteState {
  final Way way;

  const RouteLoaded({required this.way});
  @override
  List<Object> get props => [way];
}

final class RouteFailed extends RouteState {
  final String message;

  const RouteFailed({required this.message});
  @override
  List<Object> get props => [message];
}
