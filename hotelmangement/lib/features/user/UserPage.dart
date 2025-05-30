import 'package:flutter/material.dart';
import 'package:hotelmangement/features/booking_history/booking_history.dart';
import 'package:hotelmangement/features/display_hotel/display_hotel.dart';
import 'package:hotelmangement/features/profile/myProfile.dart';

class Userpage extends StatefulWidget {
  const Userpage({super.key});

  @override
  State<Userpage> createState() => _UserpageState();
}

class _UserpageState extends State<Userpage> {
  int _current_index = 0;
  final List<Widget> pages = [SearchHotel(), History(), MyProfileScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.hotel), label: "hotels"),
          BottomNavigationBarItem(
              icon: Icon(Icons.history), label: "booking history"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded), label: "profile")
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
