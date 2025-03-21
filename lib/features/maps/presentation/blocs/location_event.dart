part of 'location_bloc.dart';

sealed class LocationEvent extends Equatable {
  const LocationEvent();
}

class GetCurrentLocationEvent extends LocationEvent {
  @override
  List<Object> get props => [];

  const GetCurrentLocationEvent();
}
