import 'package:equatable/equatable.dart';

class HotelImage extends Equatable {
  final String id;
  final String imagePath;
  final String hotelId;

  const HotelImage(
      {required this.id, required this.imagePath, required this.hotelId});

  @override
  List<Object?> get props => [id, imagePath, hotelId];
}
