import 'package:flutter/material.dart';
import 'package:hotelmangement/core/initialize.dart';
import 'package:hotelmangement/features/booking_history/hotel_booking_history.dart';
import 'package:hotelmangement/features/booking_history/hotel_booking_history_test.dart';
import 'package:hotelmangement/features/booking_history/test_history.dart';
import 'package:hotelmangement/features/display_hotel/Model/hotel_model_test.dart';
import 'package:hotelmangement/features/display_hotel/display_hotel.dart';
import 'package:hotelmangement/features/google_map/google_map_polygon.dart';
import 'package:hotelmangement/features/google_map/google_map_polyline.dart';
import 'package:hotelmangement/features/homePage_rating_reviews/give_ratings_main.dart';
import 'package:hotelmangement/features/homePage_rating_reviews/view_ratings_main.dart';
import 'package:hotelmangement/features/homePage_rating_reviews/home_page_main.dart';
import 'package:hotelmangement/features/hotel_discount/hotel_offers_details_page.dart';
import 'package:hotelmangement/features/hotel_discount/offers_page.dart';
import 'package:hotelmangement/features/hotel_discount/romantic_experience_page.dart';
import 'package:hotelmangement/features/hotel_discount/visit_oceanografic_page.dart';
import 'package:hotelmangement/features/hotel_management/presentation/pages/manager_main_page.dart';
import 'package:hotelmangement/features/onboarding/page_dining.dart';
import 'package:hotelmangement/features/onboarding/page_find_room.dart';
import 'package:hotelmangement/features/onboarding/page_payment.dart';
import 'package:hotelmangement/features/onboarding/page_welcome.dart';
import 'package:hotelmangement/features/onboarding/splash_screen.dart';
import 'package:hotelmangement/features/profile/editProfile.dart';
import 'package:hotelmangement/features/profile/logout.dart';
import 'package:hotelmangement/features/profile/myProfile.dart';
import 'package:hotelmangement/test.dart';
import 'package:hotelmangement/features/booking/room_booking.dart';
//import 'package:hotelmangement/features/booking/table_booking.dart';
//import 'package:hotelmangement/features/booking_history/booking_history_test.dart';
//import 'package:hotelmangement/features/booking_history/booking_calendar.dart';

import 'package:hotelmangement/features/booking/table_details.dart';
import 'package:hotelmangement/features/booking/room_booking_details.dart';

import 'package:hotelmangement/features/booking/table_booking.dart';
//import 'package:hotelmangement/features/booking/table_booking.dart';
//import 'package:hotelmangement/features/onboarding/splash_screen.dart';


//import 'features/booking_history/hotel_booking_history.dart';



void main() async {
  // ensure the flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // initialize the project
  await initializeProject();

  // testing porpose only
  final testResult = await initTest();
  if (testResult != 1) {
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:RoomBookingPage(),

      // home: GoogleMapPolyline(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
