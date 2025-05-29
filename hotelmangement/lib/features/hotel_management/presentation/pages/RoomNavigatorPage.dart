import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelmangement/di/dicontainer.dart';
import 'package:hotelmangement/features/hotel_management/presentation/blocs/rooms/bloc/rooms_bloc.dart';
import 'package:hotelmangement/features/hotel_management/presentation/pages/RoomListPage.dart';

class Roomnavigatorpage extends StatefulWidget {
  final String managerId;
  const Roomnavigatorpage({required this.managerId, super.key});

  @override
  State<Roomnavigatorpage> createState() => _RoomnavigatorpageState();
}

class _RoomnavigatorpageState extends State<Roomnavigatorpage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => gi<RoomsBloc>(),
      child: Navigator(
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
              builder: (_) => RoomListPage(managerId: widget.managerId));
        },
      ),
    );
  }
}
