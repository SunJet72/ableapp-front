import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

part 'location_event.dart';

part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final _location = Location();

  LocationBloc() : super(LocationInitial()) {
    on<GetCurrentLocationEvent>(_onGetCurrentLocationEvent);
  }

  FutureOr<void> _onGetCurrentLocationEvent(
      GetCurrentLocationEvent event,
      Emitter<LocationState> emit,
      ) async {
    emit(LocationLoading());

    if (await _checkLocationPermission()) {
      await emit.forEach(
        _location.onLocationChanged,
        onData: (LocationData locationData) {
          if (locationData.latitude != null && locationData.longitude != null) {
            return LocationLoaded(
              location: LatLng(locationData.latitude!, locationData.longitude!),
            );
          }
          return state; // Return current state if no valid location
        },
        onError: (_, __) => const LocationError(message: "Failed to get location"),
      );
    } else {
      emit(const LocationError(message: "Cannot load location"));
    }
  }

  Future<bool> _checkLocationPermission() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        return false;
      }
    }
    PermissionStatus status = await _location.hasPermission();
    if (status == PermissionStatus.denied) {
      status = await _location.requestPermission();
      if (status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }
}
