import 'package:flutter_test/flutter_test.dart';
import 'package:hotelmangement/core/initialize.dart';
import 'package:hotelmangement/features/hotel_management/data/dataSources/hotel_management_data_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  group("HotelManagementDataSource", () {
    final hotelId = "550e8400-e29b-41d4-a716-446655440001";
    final managerId = "e8b2c4e6-353a-450d-ab3a-08a0676fd773";
    late HotelManagementDataSourceImpl dataSource;

    setUp(() async {
      await initializeProject();
      dataSource = HotelManagementDataSourceImpl(
        client: Supabase.instance.client,
      );
    });
    test("should add hotel image successfully", () async {
      dataSource.addHotelImage("adsfasdf", hotelId);
    });
  });
}
