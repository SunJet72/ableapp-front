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
        const UserState(gravel: TerrainEnum.EASY, stairs: StairsEnum.ZERO, sand: TerrainEnum.EASY),
      ) {
    on<ChangeGravelEvent>(_onChangeGravelEvent);
    on<ChangeStairsEvent>(_onChangeStairsEvent);
    on<ChangeSandEvent>(_onChangeSandEvent);
  }


  FutureOr<void> _onChangeSandEvent( ChangeSandEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(sand: event.sand));
  }

  FutureOr<void> _onChangeGravelEvent(
    ChangeGravelEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(gravel: event.gravel));
  }

  FutureOr<void> _onChangeStairsEvent(
    ChangeStairsEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(stairs: event.stairs));
  }
}
