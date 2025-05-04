import 'package:equatable/equatable.dart';

class Food extends Equatable {
  final String id;
  final String hotelId;
  final String name;
  final double price;
  final bool availability;
  final String type;

  const Food(
      {required this.id,
      required this.hotelId,
      required this.name,
      required this.price,
      required this.availability,
      required this.type});

  @override
  List<Object?> get props => [
        id,
        hotelId,
        name,
        price,
        availability,
        type,
      ];
}
