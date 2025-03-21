import 'dart:async';

import 'package:able_app/config/enums/terrain_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/enums/stairs_enum.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc()
    : super(
        const UserState(terrain: TerrainEnum.EASY, stairs: StairsEnum.ZERO),
      ) {
    on<ChangeTerrainEvent>(_onChangeTerrainEvent);
    on<ChangeStairsEvent>(_onChangeStairsEvent);
  }

  FutureOr<void> _onChangeTerrainEvent(
    ChangeTerrainEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(terrain: event.terrain));
  }

  FutureOr<void> _onChangeStairsEvent(
    ChangeStairsEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(stairs: event.stairs));
  }
}
