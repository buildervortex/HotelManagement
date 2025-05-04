import 'package:equatable/equatable.dart';

class Image extends Equatable {
  final String id;
  final String imagePath;

  const Image({required this.id, required this.imagePath});

  @override
  List<Object?> get props => [id, imagePath];
}
