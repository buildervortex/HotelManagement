// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hotelmangement/features/hotel_management/presentation/blocs/rooms/bloc/rooms_bloc.dart';
// import 'package:hotelmangement/features/hotel_management/presentation/widgets/room_list_tile.dart';

// class RoomListPage extends StatefulWidget {
//   final String managerId;
//   final String hotelId = "550e8400-e29b-41d4-a716-446655440004";
//   const RoomListPage({required this.managerId, super.key});

//   @override
//   State<RoomListPage> createState() => _RoomListPage();
// }

// class _RoomListPage extends State<RoomListPage> {
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     BlocProvider.of<RoomsBloc>(context)
//         .add(GetRoomsEvent(hotelId: widget.hotelId));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<RoomsBloc, RoomsState>(
//       buildWhen: (prev, curr) {
//         return curr is RoomLoaded;
//       },
//       builder: (con, state) {
//         if (state is RoomLoaded) {
//           return ListView.builder(
//             itemCount: state.rooms.length,
//             itemBuilder: (cont, index) {
//               final room = state.rooms[index];
//               return RoomListTile(room: room);
//             },
//           );
//         }
//         return CircularProgressIndicator();
//       },
//     );
//   }
// }











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
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(
          'Hotel Rooms',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.indigo.shade700,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.indigo.shade700.withOpacity(0.1),
              Colors.grey.shade50,
            ],
          ),
        ),
        child: BlocBuilder<RoomsBloc, RoomsState>(
          buildWhen: (prev, curr) {
            return curr is RoomLoaded;
          },
          builder: (con, state) {
            if (state is RoomLoaded) {
              if (state.rooms.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.hotel_outlined,
                        size: 80,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No rooms available',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              }
              
              return RefreshIndicator(
                onRefresh: () async {
                  BlocProvider.of<RoomsBloc>(context)
                      .add(GetRoomsEvent(hotelId: widget.hotelId));
                },
                color: Colors.indigo.shade700,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: Colors.indigo.shade700,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${state.rooms.length} rooms available',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: ListView.separated(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: state.rooms.length,
                          separatorBuilder: (context, index) => const SizedBox(height: 12),
                          itemBuilder: (cont, index) {
                            final room = state.rooms[index];
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.08),
                                    blurRadius: 15,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: RoomListTile(room: room),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.indigo.shade700.withOpacity(0.1),
                    Colors.grey.shade50,
                  ],
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.indigo.shade700,
                      ),
                      strokeWidth: 3,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Loading rooms...',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}



