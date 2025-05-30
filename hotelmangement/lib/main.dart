import 'package:flutter/material.dart';
import 'package:hotelmangement/core/initialize.dart';

import 'package:hotelmangement/features/hotel_management/presentation/pages/manager_main_page.dart';
import 'package:hotelmangement/test.dart';
import 'package:hotelmangement/features/booking/room_booking.dart';

import 'package:hotelmangement/features/booking/room_booking_details.dart';
import 'package:hotelmangement/features/booking/table_details.dart';

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
      home: ManagerMainPage(
        managerId: "e8b2c4e6-353a-450d-ab3a-08a0676fd773",
      ),
    );
  }
}
