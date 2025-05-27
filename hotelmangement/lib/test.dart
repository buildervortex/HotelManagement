import 'package:flutter_dotenv/flutter_dotenv.dart';
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

Future<int> initTest() async {
  await dotenv.load(fileName: "assets/.env");

  final test = dotenv.env["TESTING"];

  if (test == null) {
    return 0;
  }

  if (test == "true") {
    await testCall();
    return 1; // Not in test mode
  }

  return 0;
}

Future<void> testCall() async {
  final hotelId = "550e8400-e29b-41d4-a716-446655440001";
  final managerId = "e8b2c4e6-353a-450d-ab3a-08a0676fd773";

  final fileRepo = FileDataSourceImpl(client: Supabase.instance.client);
  final hotelDataSource =
      HotelManagementDataSourceImpl(client: Supabase.instance.client);

  final repo = HotelRepositoryImpl(
      dataSource: hotelDataSource, fileDataSource: fileRepo);

  // await repo.addHotelImage(hotelId, "assets/profile/logout.png");
  // await repo.addHotelPhoneNumber(hotelId, "0714587248", "admin-role");

  // await repo.createHotel("hotel1", "hoteladdress", 25.5, 12.5, managerId);
  // final hotelId1 = "5d2cf06c-ea08-48af-886e-0f798bb5b6ee";
  // await repo.deleteHotel(hotelId1);
  // await repo.deleteHotelImage("572da875-1025-44ac-be16-2ddc42aca36c");
  // await repo.deleteHotelPhoneNumber("998f39a5-a20e-4ddd-a2b3-d88608894547");
  // print(await repo.getHotel(hotelId));
  // print(await repo.getHotelImages(hotelId));
  // print(await repo.getHotelPhoneNumbers(hotelId));
  // print(await repo.isImageExists(
  //     "45b5f312-bd6e-4c32-bf22-4be676521e94", hotelId));
  await Future.delayed(const Duration(seconds: 4));
}
