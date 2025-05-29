import 'package:flutter/material.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/image.dart'
    as im;

class ItemListTile extends StatelessWidget {
  final String title;
  final String subtitile;
  final List<im.Image> images;
  const ItemListTile(
      {required this.title,
      required this.subtitile,
      required this.images,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(subtitile),
          Row(
            children: images.isNotEmpty
                ? images
                    .map((image) =>
                        Image.network(image.imageUrl!, height: 100, width: 100))
                    .toList()
                : [Text("No Data")],
          )
        ],
      ),
    );
  }
}
