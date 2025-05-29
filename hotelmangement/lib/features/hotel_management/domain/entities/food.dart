import 'package:equatable/equatable.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/food_image.dart';

class Food extends Equatable {
  final String id;
  final String hotelId;
  final String name;
  final double price;
  final bool availability;
  final String type;
  final List<FoodImage> images;

  const Food({
    required this.id,
    required this.hotelId,
    required this.name,
    required this.price,
    required this.availability,
    required this.type,
    this.images = const [],
  });

  @override
  List<Object?> get props => [
        id,
        hotelId,
        name,
        price,
        availability,
        type,
        images,
      ];

  Food copyWith({
    String? id,
    String? hotelId,
    String? name,
    double? price,
    bool? availability,
    String? type,
    List<FoodImage>? images,
  }) {
    return Food(
      id: id ?? this.id,
      hotelId: hotelId ?? this.hotelId,
      name: name ?? this.name,
      price: price ?? this.price,
      availability: availability ?? this.availability,
      type: type ?? this.type,
      images: images ?? this.images,
    );
  }
}
