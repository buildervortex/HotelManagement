import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hotelmangement/features/hotel_management/presentation/pages/FoodNavigatorPage.dart';
import 'package:hotelmangement/features/hotel_management/presentation/pages/HotelNavigatorPage.dart';
import 'package:hotelmangement/features/hotel_management/presentation/pages/RoomNavigatorPage.dart';
import 'package:hotelmangement/features/hotel_management/presentation/pages/TableNavigatorPage.dart';
import 'package:hotelmangement/features/hotel_management/presentation/pages/dashboard_page.dart';

class ManagerMainPage extends StatefulWidget {
  final String managerId;
  final List<Widget> pages;

  ManagerMainPage({required this.managerId, super.key})
      : pages = [
          ManagerDashboard(managerId: managerId),
          Hotelnavigatorpage(managerId: managerId),
          Roomnavigatorpage(managerId: managerId),
          Tablenavigatorpage(managerId: managerId),
          Foodnavigatorpage(managerId: managerId),
        ];

  @override
  State<ManagerMainPage> createState() => _ManagerMainPageState();
}

class _ManagerMainPageState extends State<ManagerMainPage> {
  int _current_index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.hotel),
            label: "Hotels",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.room),
            label: "Rooms",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.table_restaurant),
            label: "Tables",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank),
            label: "Foods",
          ),
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
      body: widget.pages[_current_index],
    );
  }
}
