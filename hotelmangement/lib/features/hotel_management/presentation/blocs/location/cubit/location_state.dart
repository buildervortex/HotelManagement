part of 'location_cubit.dart';

sealed class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

final class LocationInitial extends LocationState {}

final class LoadedCurrentLocation extends LocationState {
  final LocationData locationData;

  const LoadedCurrentLocation({required this.locationData});

  @override
  List<Object> get props => [locationData];
}

final class ErrorCurrentLocation extends LocationState {
  final String message;

  const ErrorCurrentLocation({required this.message});

  @override
  List<Object> get props => [message];
}

final class LoadingCurrentLocation extends LocationState {}
