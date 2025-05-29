import 'package:hotelmangement/features/hotel_management/domain/entities/image.dart';

class FoodImage extends Image {
  final String foodId;
  const FoodImage(
      {required this.foodId,
      required super.id,
      required super.imagePath,
      super.imageUrl});

  @override
  List<Object?> get props => [id, imagePath, foodId];

  @override
  FoodImage copyWith(
      {String? id, String? imagePath, String? foodId, String? imageUrl}) {
    return FoodImage(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      foodId: foodId ?? this.foodId,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
