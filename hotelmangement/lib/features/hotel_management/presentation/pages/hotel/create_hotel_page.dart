import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelmangement/features/hotel_management/presentation/blocs/hotels/cubit/create_hotel_cubit.dart';

class CreateHotelPage extends StatefulWidget {
  final String managerId;
  const CreateHotelPage({required this.managerId, super.key});

  @override
  State<CreateHotelPage> createState() => _CreateHotelPageState();
}

class _CreateHotelPageState extends State<CreateHotelPage> {
  final TextEditingController hotelNameController = TextEditingController();
  final TextEditingController hotelAddressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: hotelNameController,
          decoration: InputDecoration(
            labelText: "Enter the hotel name",
          ),
        ),
        TextField(
          controller: hotelAddressController,
          decoration: InputDecoration(
            labelText: "Enter the address name",
          ),
        ),
        TextButton(
            onPressed: () {
              BlocProvider.of<CreateHotelCubit>(context).setHotelDetails(
                hotelNameController.text,
                hotelAddressController.text,
                widget.managerId,
              );
              Navigator.of(context).pushNamed("/getLocation");
            },
            child: Text("Next")),
      ],
    );
  }
}
