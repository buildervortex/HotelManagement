import 'package:hotelmangement/features/hotel_management/domain/entities/famous_food.dart';

class FamousFoodModel extends FamousFood {
  const FamousFoodModel(
      {required super.id, required super.name, required super.quantity});

  factory FamousFoodModel.fromJson(Map<String, dynamic> json) {
    return FamousFoodModel(
      id: json['id'] as String,
      name: json['name'] as String,
      quantity: (json['quantity'] as num).toInt(),
    );
  }
}
