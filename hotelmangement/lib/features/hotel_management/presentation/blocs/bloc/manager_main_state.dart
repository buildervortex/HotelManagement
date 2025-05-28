part of 'manager_main_bloc.dart';

sealed class ManagerMainState extends Equatable {
  const ManagerMainState();
  
  @override
  List<Object> get props => [];
}

final class ManagerMainInitial extends ManagerMainState {}
