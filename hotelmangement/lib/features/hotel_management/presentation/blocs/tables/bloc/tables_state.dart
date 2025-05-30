part of 'tables_bloc.dart';

sealed class TablesState extends Equatable {
  const TablesState();

  @override
  List<Object> get props => [];
}

final class TablesInitial extends TablesState {}

final class TableLoading extends TablesState {}

final class TableLoaded extends TablesState {
  final List<Table> tables;

  const TableLoaded({required this.tables});

  @override
  List<Object> get props => [tables];
}

final class TableError extends TablesState {}

final class TableImageLoading extends TablesState {
  final String roomId;

  const TableImageLoading({required this.roomId});

  @override
  List<Object> get props => [roomId];
}
