import 'dart:async';

import 'package:able_app/config/enums/terrain_enum.dart';
import 'package:able_app/core/datasource/data_state.dart';
import 'package:able_app/features/maps/domain/entities/way.dart';
import 'package:able_app/features/maps/domain/repositories/route_repository.dart';
import 'package:able_app/features/maps/domain/usecases/build_route_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:latlong2/latlong.dart';

import '../../../../../config/enums/stairs_enum.dart';

part 'route_event.dart';

part 'route_state.dart';

class RouteBloc extends Bloc<RouteEvent, RouteState> {
  final _routeRepository = GetIt.I<RouteRepository>();

  RouteBloc() : super(RouteInitial()) {
    on<BuildRouteEvent>(_onBuildRouteEvent);
  }

  FutureOr<void> _onBuildRouteEvent(
    BuildRouteEvent event,
    Emitter<RouteState> emit,
  ) async {
    emit(const RouteLoading());
    final param = BuildRouteUsecaseParam(
      start: event.start,
      end: event.end,
      sandState: event.sand,
      gravelState: event.gravel,
      stairsCount: event.stairs,
    );

    final response = await BuildRouteUsecase(repository: _routeRepository)(
      param: param,
    );

    if (response is DataSuccess) {
      emit(RouteLoaded(way: response.data!));
    } else {
      emit(RouteFailed(message: response.message ?? "Unknown error"));
    }
  }
}
