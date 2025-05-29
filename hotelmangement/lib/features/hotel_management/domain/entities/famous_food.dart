import 'package:equatable/equatable.dart';

class FamousFood extends Equatable {
  final String id;
  final String name;
  final int quantity;

  const FamousFood(
      {required this.id, required this.name, required this.quantity});

  @override
  List<Object?> get props => [
        id,
        name,
        quantity,
      ];
}
