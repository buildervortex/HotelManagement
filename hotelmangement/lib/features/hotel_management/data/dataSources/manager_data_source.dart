import 'package:hotelmangement/features/hotel_management/data/models/manager_model.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/manager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ManagerDataSource {
  Future<Manager> addManager(String managerId);
}

class ManagerDataSourceImpl implements ManagerDataSource {
  final SupabaseClient client;

  ManagerDataSourceImpl({required this.client});

  @override
  Future<Manager> addManager(String managerId) async {
    final response = await client
        .from("manager")
        .insert({"id": managerId})
        .select()
        .single();
    if (response.isEmpty) {
      throw Exception("Failed to add hotel image");
    }

    final data = await client
        .from("manager_details")
        .select()
        .eq("id", managerId)
        .single();
    return ManagerModel.fromJson(data);
  }
}
