import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelmangement/di/dicontainer.dart';
import 'package:hotelmangement/features/hotel_management/presentation/blocs/hotels/bloc/hotels_bloc.dart';
import 'package:hotelmangement/features/hotel_management/presentation/blocs/hotels/cubit/create_hotel_cubit.dart';
import 'package:hotelmangement/features/hotel_management/presentation/blocs/location/cubit/location_cubit.dart';
import 'package:hotelmangement/features/hotel_management/presentation/pages/HotelListPage.dart';
import 'package:hotelmangement/features/hotel_management/presentation/pages/hotel/add_hotel_images_page.dart';
import 'package:hotelmangement/features/hotel_management/presentation/pages/hotel/create_hotel_page.dart';
import 'package:hotelmangement/features/hotel_management/presentation/pages/locationGetPage.dart';

class Hotelnavigatorpage extends StatefulWidget {
  final String managerId;
  const Hotelnavigatorpage({required this.managerId, super.key});

  @override
  State<Hotelnavigatorpage> createState() => HotelnavigatorpageState();
}

class HotelnavigatorpageState extends State<Hotelnavigatorpage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (cont) => gi<HotelsBloc>()),
        BlocProvider(create: (cont) => gi<CreateHotelCubit>()),
        BlocProvider(create: (cont) => gi<LocationCubit>()),
      ],
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

      case "/getLocation":
        return MaterialPageRoute(builder: (_) => Locationgetpage());

      case "/getImages":
        return MaterialPageRoute(builder: (_) => AddHotelImagesPage());
      default:
        return MaterialPageRoute(
            builder: (_) => Center(
                  child: Text("unknown route"),
                ));
    }
  }
}
