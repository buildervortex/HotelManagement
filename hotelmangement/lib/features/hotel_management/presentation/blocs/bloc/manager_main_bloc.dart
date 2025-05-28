import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'manager_main_event.dart';
part 'manager_main_state.dart';

class ManagerMainBloc extends Bloc<ManagerMainEvent, ManagerMainState> {
  ManagerMainBloc() : super(ManagerMainInitial()) {
    on<ManagerMainEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
