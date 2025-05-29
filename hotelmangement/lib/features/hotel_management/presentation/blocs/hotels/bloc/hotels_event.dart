part of 'hotels_bloc.dart';

sealed class HotelsEvent extends Equatable {
  const HotelsEvent();

  @override
  List<Object> get props => [];
}

class GetHotelsEvent extends HotelsEvent {
  final String managerId;

  const GetHotelsEvent({required this.managerId});
}

