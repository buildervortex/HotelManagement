import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel_image.dart';
import 'package:hotelmangement/features/hotel_management/presentation/blocs/hotels/bloc/hotels_bloc.dart';

class HotelListTile extends StatefulWidget {
  final Hotel hotel;
  const HotelListTile({required this.hotel, super.key});

  @override
  State<HotelListTile> createState() => _HotelListTileState();
}

class _HotelListTileState extends State<HotelListTile> {
  List<HotelImage> _cachedImages = [];
  @override
  Widget build(BuildContext context) {
    return BlocListener<HotelsBloc, HotelsState>(
      listenWhen: (prev, curr) =>
          curr is HotelImageLoaded && curr.hotelId == widget.hotel.id,
      listener: (cont, state) {
        if (state is HotelImageLoaded && state.hotelId == widget.hotel.id) {
          setState(() {
            _cachedImages = state.images;
          });
        }
      },
      child: ListTile(
        title: Text(widget.hotel.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.hotel.address),
            Row(
              children: _cachedImages.isNotEmpty
                  ? _cachedImages.map((image) => Text(image.imageUrl ?? "no url")).toList()
                  : [Text("No Data")],
            )
          ],
        ),
      ),
    );
  }
}
