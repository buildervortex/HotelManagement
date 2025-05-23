import 'package:hotelmangement/features/hotel_management/domain/entities/image.dart';

class FoodImage extends Image {
  final String foodId;
  const FoodImage(
      {required this.foodId, required super.id, required super.imagePath});

  @override
  List<Object?> get props => [id, imagePath, foodId];
}
