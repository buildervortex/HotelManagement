part of 'hotels_bloc.dart';

sealed class HotelsState extends Equatable {
  const HotelsState();
  
  @override
  List<Object> get props => [];
}

final class HotelsInitial extends HotelsState {}
