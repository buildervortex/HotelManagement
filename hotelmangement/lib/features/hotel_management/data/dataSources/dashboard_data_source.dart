import 'package:hotelmangement/features/hotel_management/data/models/active_booking_model.dart';
import 'package:hotelmangement/features/hotel_management/data/models/famous_food_model.dart';
import 'package:hotelmangement/features/hotel_management/data/models/hotel_state_model.dart';
import 'package:hotelmangement/features/hotel_management/data/models/rating_count_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class DashboardDataSource {
  Future<List<ActiveBookingModel>> activeTableBookings(
      DateTime datetime, String managerId);
  Future<List<ActiveBookingModel>> activeTakeAwayBookings(
      DateTime datetime, String managerId);
  Future<List<FamousFoodModel>> getFamousFoodInAll();
  Future<List<FamousFoodModel>> getFamousFoodsInCurrentManagerHotels(
      String managerId);
  Future<List<RatingCountModel>> getHotelRatings(String managerId);
  Future<List<HotelStateModel>> getHotelState(String managerId);
}

class DashboardDataSourceImpl implements DashboardDataSource {
  final SupabaseClient client;

  DashboardDataSourceImpl({required this.client});

  @override
  Future<List<ActiveBookingModel>> activeTableBookings(
      DateTime datetime, String managerId) async {
    final response = await client.rpc("active_table_bookings", params: {
      "date_time": datetime.toIso8601String(),
      "manager_id": managerId,
    }).select();

    if (response.isEmpty) {
      throw Exception("active table bookings not found");
    } else {
      return response
          .map<ActiveBookingModel>((data) => ActiveBookingModel.fromJson(data))
          .toList();
    }
  }

  @override
  Future<List<ActiveBookingModel>> activeTakeAwayBookings(
      DateTime datetime, String managerId) async {
    final response = await client.rpc("active_take_away_orders", params: {
      "date_time": datetime.toIso8601String(),
      "manager_id": managerId,
    }).select();

    if (response.isEmpty) {
      throw Exception("active take away bookings not found");
    } else {
      return response
          .map<ActiveBookingModel>((data) => ActiveBookingModel.fromJson(data))
          .toList();
    }
  }

  @override
  Future<List<FamousFoodModel>> getFamousFoodInAll() async {
    final response = await client.from("famous_foods").select();

    if (response.isEmpty) {
      throw Exception("famous food in all not found");
    } else {
      return response
          .map<FamousFoodModel>((data) => FamousFoodModel.fromJson(data))
          .toList();
    }
  }

  @override
  Future<List<FamousFoodModel>> getFamousFoodsInCurrentManagerHotels(
      String managerId) async {
    final response = await client.rpc("get_famous_foods_for_manager", params: {
      "manager_id": managerId,
    }).select();

    if (response.isEmpty) {
      throw Exception("famous food models not found");
    } else {
      return response
          .map<FamousFoodModel>((data) => FamousFoodModel.fromJson(data))
          .toList();
    }
  }

  @override
  Future<List<RatingCountModel>> getHotelRatings(String managerId) async {
    final response = await client.rpc("hotel_rating_count", params: {
      "manager_id": managerId,
    }).select();

    if (response.isEmpty) {
      throw Exception("famous food models not found");
    } else {
      return response
          .map<RatingCountModel>((data) => RatingCountModel.fromJson(data))
          .toList();
    }
  }

  @override
  Future<List<HotelStateModel>> getHotelState(String managerId) async {
    final response = await client.rpc("hotels_state", params: {
      "manager_id": managerId,
    }).select();

    if (response.isEmpty) {
      throw Exception("hotel state not found");
    } else {
      return response
          .map<HotelStateModel>((data) => HotelStateModel.fromJson(data))
          .toList();
    }
  }
}
