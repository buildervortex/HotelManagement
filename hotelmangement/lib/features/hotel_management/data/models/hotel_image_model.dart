import 'package:hotelmangement/features/hotel_management/domain/entities/hotel_image.dart';

class HotelImageModel extends HotelImage {
  const HotelImageModel(
      {required super.id, required super.imagePath, required super.hotelId});

  factory HotelImageModel.fromJson(Map<String, dynamic> json) {
    return HotelImageModel(
      id: json['id'] as String,
      imagePath: json['file'] as String,
      hotelId: json['hotel_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'file': imagePath,
      'hotel_id': hotelId,
    };
  }
}
