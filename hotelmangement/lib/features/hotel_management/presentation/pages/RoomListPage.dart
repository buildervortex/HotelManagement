import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelmangement/features/hotel_management/presentation/blocs/rooms/bloc/rooms_bloc.dart';
import 'package:hotelmangement/features/hotel_management/presentation/widgets/room_list_tile.dart';

class RoomListPage extends StatefulWidget {
  final String managerId;
  final String hotelId = "550e8400-e29b-41d4-a716-446655440004";
  const RoomListPage({required this.managerId, super.key});

  @override
  State<RoomListPage> createState() => _RoomListPage();
}

class _RoomListPage extends State<RoomListPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<RoomsBloc>(context)
        .add(GetRoomsEvent(hotelId: widget.hotelId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomsBloc, RoomsState>(
      buildWhen: (prev, curr) {
        return curr is RoomLoaded;
      },
      builder: (con, state) {
        if (state is RoomLoaded) {
          return ListView.builder(
            itemCount: state.rooms.length,
            itemBuilder: (cont, index) {
              final room = state.rooms[index];
              return RoomListTile(room: room);
            },
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
