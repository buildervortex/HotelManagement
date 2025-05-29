import 'package:equatable/equatable.dart';

class RatingCount extends Equatable {
  final String id;
  final String name;
  final int count;

  const RatingCount(
      {required this.id, required this.name, required this.count});
  @override
  List<Object?> get props => [
        id,
        name,
        count,
      ];

  RatingCount copyWith({
    String? id,
    String? name,
    int? count,
  }) {
    return RatingCount(
        id: id ?? this.id, name: name ?? this.name, count: count ?? this.count);
  }
}
