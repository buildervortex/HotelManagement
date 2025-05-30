import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelmangement/features/hotel_management/presentation/blocs/hotels/bloc/hotels_bloc.dart';
import 'package:hotelmangement/features/hotel_management/presentation/widgets/hotel_list_tile.dart';

class Hotellistpage extends StatefulWidget {
  final String managerId;
  const Hotellistpage({required this.managerId, super.key});

  @override
  State<Hotellistpage> createState() => _HotellistpageState();
}

class _HotellistpageState extends State<Hotellistpage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<HotelsBloc>(context)
        .add(GetHotelsEvent(managerId: widget.managerId));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/createHotel");
            },
            child: Text("Create Hotel")),
        Expanded(
          child: BlocBuilder<HotelsBloc, HotelsState>(
            buildWhen: (prev, curr) {
              return curr is HotelLoaded;
            },
            builder: (con, state) {
              if (state is HotelLoaded) {
                return ListView.builder(
                  itemCount: state.hotels.length,
                  itemBuilder: (cont, index) {
                    final hotel = state.hotels[index];
                    return HotelListTile(hotel: hotel);
                  },
                );
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ],
    );
  }
}
