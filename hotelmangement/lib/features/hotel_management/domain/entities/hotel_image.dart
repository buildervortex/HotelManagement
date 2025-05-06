import 'package:hotelmangement/features/hotel_management/domain/entities/image.dart';

class HotelImage extends Image {
  final String hotelId;

  const HotelImage(
      {required super.id, required super.imagePath, required this.hotelId});

  @override
  List<Object?> get props => [id, imagePath, hotelId];
}
