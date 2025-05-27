import 'package:flutter/material.dart';
import 'package:hotelmangement/core/initialize.dart';
import 'package:hotelmangement/features/homePage_rating_reviews/give_ratings_main.dart';
import 'package:hotelmangement/features/homePage_rating_reviews/home_page_main.dart';
import 'package:hotelmangement/features/homePage_rating_reviews/view_ratings_main.dart';
import 'package:hotelmangement/features/booking/room_booking.dart';
import 'package:hotelmangement/features/booking/table_booking.dart';
import 'package:hotelmangement/features/google_map/google_map.dart';
import 'package:hotelmangement/features/google_map/google_map_polygon.dart';
// import 'package:hotelmangement/features/live_chat/screens/chat_list_screen.dart';
import 'package:hotelmangement/features/display_hotel/display_hotel.dart';
// import 'package:hotelmangement/features/google_map/google_map_polyline.dart';
import 'package:hotelmangement/features/auth/login.dart';
import "package:hotelmangement/features/booking_history/booking_history.dart";

import 'package:hotelmangement/features/hotel_management/data/dataSources/file_data_source.dart';
import 'package:hotelmangement/features/hotel_management/data/dataSources/hotel_management_data_source.dart';
import 'package:hotelmangement/features/hotel_management/data/repositories/file_repository_impl.dart';
import 'package:hotelmangement/features/hotel_management/data/repositories/hotel_repository_impl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  // ensure the flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // initialize the project
  await initializeProject();

  // testing porpose only
  // await testCall();

  runApp(const MyApp());
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
      home: RatingApp(),
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

Future<void> testCall() async {
  final hotelId = "550e8400-e29b-41d4-a716-446655440001";
  final managerId = "e8b2c4e6-353a-450d-ab3a-08a0676fd773";

  final fileRepo = FileDataSourceImpl(client: Supabase.instance.client);
  final hotelDataSource =
      HotelManagementDataSourceImpl(client: Supabase.instance.client);

  final repo = HotelRepositoryImpl(
      dataSource: hotelDataSource, fileDataSource: fileRepo);

  // await repo.addHotelPhoneNumber(hotelId, "0714587248", "admin-role");

  await repo.createHotel("hotel1", "hoteladdress", 25.5, 12.5, managerId);
  final hotelId1 = "06c25869-2af2-46e4-916b-800e6f00e419";
  await repo.deleteHotel(hotelId1);
}
