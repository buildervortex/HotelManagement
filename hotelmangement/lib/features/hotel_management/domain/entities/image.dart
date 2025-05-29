import 'package:equatable/equatable.dart';

class Image extends Equatable {
  final String id;
  final String imagePath;
  final String? imageUrl;

  const Image({required this.id, required this.imagePath, this.imageUrl});

  @override
  List<Object?> get props => [id, imagePath, imageUrl];

  Image copyWith({
    String? id,
    String? imagePath,
    String? imageUrl,
  }) {
    return Image(
        id: id ?? this.id,
        imagePath: imagePath ?? this.imagePath,
        imageUrl: imageUrl ?? this.imageUrl);
  }
}
