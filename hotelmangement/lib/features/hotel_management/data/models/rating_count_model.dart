import 'package:hotelmangement/features/hotel_management/domain/entities/rating_count.dart';

class RatingCountModel extends RatingCount {
  const RatingCountModel(
      {required super.id, required super.name, required super.count});

  factory RatingCountModel.fromJson(Map<String, dynamic> json) {
    return RatingCountModel(
      id: json['id'] as String,
      name: json['name'] as String,
      count: (json['count'] as num).toInt(),
    );
  }
}
