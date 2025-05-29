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
}
