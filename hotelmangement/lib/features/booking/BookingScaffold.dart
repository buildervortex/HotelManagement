import 'package:flutter/material.dart';
import 'package:hotelmangement/features/booking/room_booking.dart';
import 'package:hotelmangement/features/booking/table_booking.dart';
import 'package:hotelmangement/features/booking/take_away_food_booking.dart';

class Bookingscaffold extends StatefulWidget {
  const Bookingscaffold({super.key});

  @override
  State<Bookingscaffold> createState() => _BookingscaffoldState();
}

class _BookingscaffoldState extends State<Bookingscaffold> {
  int _current_index = 0;
  final List<Widget> pages = [
    RoomBookingPage(),
    TableBookingPage(),
    TakeAwayBookingApp()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bookings"),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.room), label: "room booking"),
          BottomNavigationBarItem(
              icon: Icon(Icons.table_bar), label: "table booking"),
          BottomNavigationBarItem(
              icon: Icon(Icons.food_bank), label: "take away booking")
        ],
        currentIndex: _current_index,
        onTap: (index) => setState(
          () {
            _current_index = index;
          },
        ),
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
      ),
      body: pages[_current_index],
    );
  }
}
