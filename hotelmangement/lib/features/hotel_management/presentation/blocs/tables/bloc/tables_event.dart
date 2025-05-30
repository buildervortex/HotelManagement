part of 'tables_bloc.dart';

sealed class TablesEvent extends Equatable {
  const TablesEvent();

  @override
  List<Object> get props => [];
}

class GetTablesEvent extends TablesEvent {
  final String hotelId;

  const GetTablesEvent({required this.hotelId});
}
