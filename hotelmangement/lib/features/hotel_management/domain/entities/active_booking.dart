import 'package:equatable/equatable.dart';

class ActiveBooking extends Equatable {
  final String id;
  final String name;
  final int count;

  const ActiveBooking(
      {required this.id, required this.name, required this.count});
  @override
  List<Object?> get props => [
        id,
        name,
        count,
      ];

  ActiveBooking copyWith({String? id, String? name, int? count}) {
    return ActiveBooking(
        id: id ?? this.id, name: name ?? this.name, count: count ?? this.count);
  }
}
