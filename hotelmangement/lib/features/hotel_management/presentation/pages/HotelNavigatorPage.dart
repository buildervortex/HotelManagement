import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelmangement/di/dicontainer.dart';
import 'package:hotelmangement/features/hotel_management/presentation/blocs/hotels/bloc/hotels_bloc.dart';
import 'package:hotelmangement/features/hotel_management/presentation/pages/HotelListPage.dart';
import 'package:hotelmangement/features/hotel_management/presentation/pages/hotel/create_hotel_page.dart';

class Hotelnavigatorpage extends StatefulWidget {
  final String managerId;
  const Hotelnavigatorpage({required this.managerId, super.key});

  @override
  State<Hotelnavigatorpage> createState() => HotelnavigatorpageState();
}

class HotelnavigatorpageState extends State<Hotelnavigatorpage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => gi<HotelsBloc>(),
      child: Navigator(initialRoute: "/listHotels", onGenerateRoute: onRoute),
    );
  }

  MaterialPageRoute onRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/listHotels":
        return MaterialPageRoute(
            builder: (_) => Hotellistpage(managerId: widget.managerId));

      case "/createHotel":
        return MaterialPageRoute(
            builder: (_) => CreateHotelPage(managerId: widget.managerId));
      default:
        return MaterialPageRoute(
            builder: (_) => Center(
                  child: Text("unknown route"),
                ));
    }
  }
}
