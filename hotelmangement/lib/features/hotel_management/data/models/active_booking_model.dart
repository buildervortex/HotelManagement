import 'package:hotelmangement/features/hotel_management/domain/entities/active_booking.dart';

class ActiveBookingModel extends ActiveBooking {
  const ActiveBookingModel(
      {required super.id, required super.name, required super.count});

  factory ActiveBookingModel.fromJson(Map<String, dynamic> json) {
    return ActiveBookingModel(
      id: json['id'] as String,
      name: json['name'] as String,
      count: (json['count'] as num).toInt(),
    );
  }
}
