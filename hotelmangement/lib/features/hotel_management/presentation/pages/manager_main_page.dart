import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelmangement/di/dicontainer.dart';
import 'package:hotelmangement/features/hotel_management/presentation/blocs/dashboard/cubit/get_active_table_bookings_cubit.dart';
import 'package:hotelmangement/features/hotel_management/presentation/blocs/dashboard/cubit/get_active_takeaway_bookings_cubit.dart';
import 'package:hotelmangement/features/hotel_management/presentation/blocs/dashboard/cubit/get_famous_foods_in_all_cubit.dart';
import 'package:hotelmangement/features/hotel_management/presentation/blocs/dashboard/cubit/get_hotel_ratings_cubit.dart';
import 'package:hotelmangement/features/hotel_management/presentation/blocs/dashboard/cubit/get_hotel_state_cubit.dart';
import 'package:hotelmangement/features/hotel_management/presentation/blocs/dashboard/cubit/get_own_hotels_famous_foods_cubit.dart';
import 'package:hotelmangement/features/hotel_management/presentation/pages/FoodNavigatorPage.dart';
import 'package:hotelmangement/features/hotel_management/presentation/pages/HotelNavigatorPage.dart';
import 'package:hotelmangement/features/hotel_management/presentation/pages/RoomNavigatorPage.dart';
import 'package:hotelmangement/features/hotel_management/presentation/pages/TableNavigatorPage.dart';
import 'package:hotelmangement/features/hotel_management/presentation/pages/dashboard_page.dart';

class ManagerMainPage extends StatefulWidget {
  final String managerId;

  const ManagerMainPage({required this.managerId, super.key});

  @override
  State<ManagerMainPage> createState() => _ManagerMainPageState();
}

class _ManagerMainPageState extends State<ManagerMainPage> {
  int _current_index = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      getBlocProvidedDashBoard(widget.managerId),
      Hotelnavigatorpage(managerId: widget.managerId),
      Roomnavigatorpage(managerId: widget.managerId),
      Tablenavigatorpage(managerId: widget.managerId),
      Foodnavigatorpage(managerId: widget.managerId),
    ];
  }

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
      body: _pages[_current_index],
    );
  }

  Widget getBlocProvidedDashBoard(String managerId) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (con) => gi<GetActiveTableBookingsCubit>()),
        BlocProvider(create: (con) => gi<GetActiveTakeawayBookingsCubit>()),
        BlocProvider(create: (con) => gi<GetFamousFoodsInAllCubit>()),
        BlocProvider(create: (con) => gi<GetHotelRatingsCubit>()),
        BlocProvider(create: (con) => gi<GetHotelStateCubit>()),
        BlocProvider(create: (con) => gi<GetOwnHotelsFamousFoodsCubit>()),
      ],
      child: ManagerDashboard(managerId: managerId),
    );
  }
}
