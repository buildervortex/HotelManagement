import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/table.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/table/get_tables_in_hotel.dart';

part 'tables_event.dart';
part 'tables_state.dart';

class TablesBloc extends Bloc<TablesEvent, TablesState> {
  final GetTablesInHotel getTablesInHotel;

  TablesBloc({required this.getTablesInHotel}) : super(TablesInitial()) {
    _registerListners();
  }

  void _registerListners() {
    on<GetTablesEvent>(_onTablesLoaded);
  }

  Future<void> _onTablesLoaded(
      GetTablesEvent event, Emitter<TablesState> emit) async {
    emit(TableLoading());

    final tableListOrFailure =
        await getTablesInHotel(Params(hotelId: event.hotelId));

    tableListOrFailure.fold((error) => emit(TableError()), (tableList) {
      emit(TableLoaded(tables: tableList));
    });
  }
}
