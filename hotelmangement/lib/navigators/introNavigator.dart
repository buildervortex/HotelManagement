import 'package:flutter/material.dart';
import 'package:hotelmangement/features/onboarding/splash_screen.dart';

class Intronavigator extends StatelessWidget {
  const Intronavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) =>
          MaterialPageRoute(builder: (_) => SplashScreen()),
    );
  }

  // MaterialPageRoute onRoute(RouteSettings settings) {
  //   switch (settings.name) {
  //     case "/":
  //       return MaterialPageRoute(
  //           builder: (_) => Hotellistpage(managerId: widget.managerId));

  //     case "/createHotel":
  //       return MaterialPageRoute(
  //           builder: (_) => CreateHotelPage(managerId: widget.managerId));

  //     case "/getLocation":
  //       return MaterialPageRoute(builder: (_) => Locationgetpage());

  //     case "/getImages":
  //       return MaterialPageRoute(builder: (_) => AddHotelImagesPage());
  //     case "/getNumbers":
  //       return MaterialPageRoute(builder: (_) => AddHotelPhoneNumbersPage());
  //     default:
  //       return MaterialPageRoute(
  //           builder: (_) => Center(
  //                 child: Text("unknown route"),
  //               ));
  //   }
  // }
}
