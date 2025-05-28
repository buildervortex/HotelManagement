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
}
