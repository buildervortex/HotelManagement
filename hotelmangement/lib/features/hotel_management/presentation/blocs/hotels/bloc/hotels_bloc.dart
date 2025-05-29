import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'hotels_event.dart';
part 'hotels_state.dart';

class HotelsBloc extends Bloc<HotelsEvent, HotelsState> {
  HotelsBloc() : super(HotelsInitial()) {
    on<HotelsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
