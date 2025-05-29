import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/room.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/room_image.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/room/get_rooms_in_hotel.dart';
import 'package:hotelmangement/features/hotel_management/presentation/blocs/helpers/cubit/hotel_room_images_cubit.dart';

part 'rooms_event.dart';
part 'rooms_state.dart';

class RoomsBloc extends Bloc<RoomsEvent, RoomsState> {
  final GetRoomsInHotel getRoomsInHotel;
  final HotelRoomImagesCubit hotelRoomImagesCubit;

  List<Room> _rooms = [];

  RoomsBloc({required this.getRoomsInHotel, required this.hotelRoomImagesCubit})
      : super(RoomsInitial()) {
    _registerListners();
    _registerCubitListners();
  }

  void _registerListners() {
    on<GetRoomsEvent>(_onRoomLoad);
    on<RoomImageReceived>(_onRoomImageLoaded);
  }

  Future<void> _onRoomLoad(
      GetRoomsEvent event, Emitter<RoomsState> emit) async {
    emit(RoomLoading());

    final hotelListOrFailure =
        await getRoomsInHotel(Params(hotelId: event.hotelId));

    hotelListOrFailure.fold((error) => emit(RoomError()), (hotelList) {
      _rooms = hotelList;
      emit(RoomLoaded(rooms: _rooms.map((room) => room.copyWith()).toList()));

      for (var room in _rooms) {
        hotelRoomImagesCubit.loadImages(room.id);
      }
    });
  }

  void _registerCubitListners() {
    // listen for room image cubit changes
    hotelRoomImagesCubit.stream.listen((imagesState) {
      if (imagesState is HotelRoomImagesLoaded) {
        add(RoomImageReceived(
            roomId: imagesState.roomId, images: imagesState.roomImages));
      }
    });
  }

  void _onRoomImageLoaded(
      RoomImageReceived event, Emitter<RoomsState> emit) async {
    List<Room> roomList = [];

    for (var room in _rooms) {
      if (room.id == event.roomId) {
        roomList.add(room.copyWith(images: event.images));
        emit(RoomImageLoaded(roomId: event.roomId, images: event.images));
        continue;
      }
      roomList.add(room.copyWith());
    }
    _rooms = roomList;
  }
}
