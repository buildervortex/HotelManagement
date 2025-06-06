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
import 'package:hotelmangement/features/hotel_management/data/dataSources/dashboard_data_source.dart';

import 'package:hotelmangement/features/hotel_management/data/dataSources/file_data_source.dart';
import 'package:hotelmangement/features/hotel_management/data/dataSources/hotel_food_data_source.dart';
import 'package:hotelmangement/features/hotel_management/data/dataSources/hotel_management_data_source.dart';
import 'package:hotelmangement/features/hotel_management/data/dataSources/hotel_room_data_source.dart';
import 'package:hotelmangement/features/hotel_management/data/dataSources/hotel_table_data_source.dart';
import 'package:hotelmangement/features/hotel_management/data/dataSources/manager_data_source.dart';
import 'package:hotelmangement/features/hotel_management/data/repositories/dashboard_repository_impl.dart';
import 'package:hotelmangement/features/hotel_management/data/repositories/file_repository_impl.dart';
import 'package:hotelmangement/features/hotel_management/data/repositories/hotel_food_repository_impl.dart';
import 'package:hotelmangement/features/hotel_management/data/repositories/hotel_repository_impl.dart';
import 'package:hotelmangement/features/hotel_management/data/repositories/hotel_room_repository_impl.dart';
import 'package:hotelmangement/features/hotel_management/data/repositories/hotel_table_repository_impl.dart';
import 'package:hotelmangement/features/hotel_management/data/repositories/manager_repository_impl.dart';
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
  final roomId = "660e8400-e29b-41d4-a716-446655440001";
  final foodId = "770e8400-e29b-41d4-a716-446655440001";

  final fileRepo = FileDataSourceImpl(client: Supabase.instance.client);
  final hotelDataSource =
      HotelManagementDataSourceImpl(client: Supabase.instance.client);
  final managerDataSource =
      ManagerDataSourceImpl(client: Supabase.instance.client);
  final roomDataSource =
      HotelRoomDataSourceImpl(client: Supabase.instance.client);
  final foodDataSource =
      HotelFoodDataSourceImpl(client: Supabase.instance.client);
  final tableDataSource =
      HotelTableDataSourceImpl(client: Supabase.instance.client);
  final dashboardDataSource =
      DashboardDataSourceImpl(client: Supabase.instance.client);

  final repo = HotelRepositoryImpl(
      dataSource: hotelDataSource, fileDataSource: fileRepo);
  final mrepo = ManagerRepositoryImpl(dataSource: managerDataSource);
  final rrepo = HotelRoomRepositoryImpl(
      dataSource: roomDataSource, fileDataSource: fileRepo);
  final frepo = HotelFoodRepositoryImpl(
      dataSource: foodDataSource, fileDataSource: fileRepo);
  final trepo = HotelTableRepositoryImpl(dataSource: tableDataSource);
  final drepo = DashboardRepositoryImpl(dataSource: dashboardDataSource);

  // final response = await Supabase.instance.client.rpc("get_booking_room_image",
  //     params: {
  //       "room_booking_id": '224c4f8c-e525-4dd0-ad6b-f2ccd16e1143'
  //     }).single();

  // print("Response: $response");
  // print("booking_id ${response['booking_id']}");
  // print("room_id ${response['room_id']}");
  // print("file ${response['file']}");

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
  // print(await repo.updateHotel("422abcee-b131-402f-8bc9-20c97d5e6970",
  //     "updatedhotel", "hoteladdress2", null, null, "newmainimage.png"));

  // print(await mrepo.addManager("dbd0ffcf-6bc2-477a-8b24-da53dc8baefc"));

  // await rrepo.addRoomImage(roomId, "assets/profile/logout.png");
  // print(await rrepo.createRoom(
  //     hotelId: hotelId,
  //     roomNumber: "101",
  //     description: "A cozy room with a beautiful view",
  //     space: 4,
  //     floor: "1st Floor",
  //     price: 100.0,
  //     available: true));
  // await rrepo.deleteRoom(
  //     roomId: "4225588e-707d-4ebe-b4c5-e5fb10670f73",
  //     hotelId: "550e8400-e29b-41d4-a716-446655440001");
  // print("done");
  // await rrepo.deleteRoomImage("b1538c36-f2f2-4ab5-b72a-39a60901fb7d");
  // print(await rrepo.getRoomImages(roomId));
  // print(await rrepo.getRooms(hotelId: hotelId));
  // print(await rrepo.isImageExists(
  //     "389c8a6e-a14d-49ff-8882-c981e80a5a95", roomId));
  // print(await rrepo.updateRoom(
  //     roomId: "4225588e-707d-4ebe-b4c5-e5fb10670f73",
  //     hotelId: hotelId,
  //     roomNumber: "102",
  //     space: 50,
  //     price: 120.0,
  //     available: false));

  // frepo.addFoodImage(foodId, "assets/profile/logout.png");
  // print(await frepo.createFood(
  //     hotelId: hotelId,
  //     name: "Pasta",
  //     price: 12.99,
  //     available: true,
  //     type: "food"));
  // await frepo.deleteFood(foodId: "9910e141-bc83-4681-aaf3-066bc2d28753");
  // frepo.deleteFoodImage("a7ee0a31-e342-4055-9d62-44d6019908fe", "770e8400-e29b-41d4-a716-446655440001");
  // print(await frepo.getFoodImages(foodId));
  // print(await frepo.getFoods(hotelId: hotelId));
  // print(await frepo.isImageExists("054e7174-c909-480a-a673-7e934cd01254", "770e8400-e29b-41d4-a716-446655440010"));
  // print(await frepo.updateFood(
  //     foodId: "9910e141-bc83-4681-aaf3-066bc2d28753",
  //     name: "Updated Pasta",
  //     price: 15.99,
  //     ));

  // print(await trepo.createTable(
  //     hotelId: hotelId,
  //     tableNumber: "T1",
  //     space: 4,
  //     floor: "1st Floor",
  //     available: true));
  // await trepo.deleteTable(
  //     tableId: "96e97d2b-4ce0-4f5e-b138-17d2ee078798", hotelId: hotelId);
  // print(await trepo.getTables(hotelId: hotelId));
  // print(await trepo.updateTable(
  //     tableId: "96e97d2b-4ce0-4f5e-b138-17d2ee078798",
  //     hotelId: hotelId,
  //     tableNumber: "T2",
  //     space: 60,
  //     available: false));

  // print(await drepo.getFamousFoodInAll());
  // print(await drepo.getFamousFoodsInCurrentManagerHotels(managerId: managerId));
  // print(await drepo.activeTableBookings(
  //     datetime: DateTime.now(), managerId: managerId));
  // print(await drepo.activeTakeAwayBookings(
  //     datetime: DateTime.now(), managerId: managerId));
  // print(await drepo.getHotelRatings(managerId: managerId));
  // print(await drepo.getHotelState(managerId: managerId));

  await Future.delayed(const Duration(seconds: 4));
}
