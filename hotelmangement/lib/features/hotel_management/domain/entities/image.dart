import 'package:equatable/equatable.dart';

class Image extends Equatable {
  final String id;
  final String imagePath;

  const Image({required this.id, required this.imagePath});

  @override
  List<Object?> get props => [id, imagePath];

  Image copyWith({
    String? id,
    String? imagePath,
  }) {
    return Image(id: id ?? this.id, imagePath: imagePath ?? this.imagePath);
  }
}
