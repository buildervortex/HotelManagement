import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/room.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/room_image.dart';
import 'package:hotelmangement/features/hotel_management/presentation/blocs/rooms/bloc/rooms_bloc.dart';
import 'package:hotelmangement/features/hotel_management/presentation/widgets/item_list_tile.dart';

class RoomListTile extends StatefulWidget {
  final Room room;
  const RoomListTile({required this.room, super.key});

  @override
  State<RoomListTile> createState() => _RoomListTileState();
}

class _RoomListTileState extends State<RoomListTile> {
  List<RoomImage> _cachedImages = [];
  @override
  Widget build(BuildContext context) {
    return BlocListener<RoomsBloc, RoomsState>(
      listenWhen: (prev, curr) =>
          curr is RoomImageLoaded && curr.roomId == widget.room.id,
      listener: (cont, state) {
        if (state is RoomImageLoaded && state.roomId == widget.room.id) {
          setState(() {
            _cachedImages = state.images;
          });
        }
      },
      child: ItemListTile(
        title: widget.room.roomNumber,
        subtitile: widget.room.floor,
        images: _cachedImages,
      ),
    );
  }
}
