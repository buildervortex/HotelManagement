import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelmangement/features/hotel_management/presentation/blocs/hotels/cubit/create_hotel_cubit.dart';

class AddHotelPhoneNumbersPage extends StatefulWidget {
  const AddHotelPhoneNumbersPage({super.key});

  @override
  State<AddHotelPhoneNumbersPage> createState() =>
      _AddHotelPhoneNumbersPageState();
}

class _AddHotelPhoneNumbersPageState extends State<AddHotelPhoneNumbersPage> {
  final TextEditingController numberController = TextEditingController();
  final TextEditingController roleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<CreateHotelCubit, CreateHotelState>(
              builder: (conte, state) {
            if (state is CreateHotelPhoneNumberAdded) {
              return Column(
                children: state.phoneNumbers
                    .map((number) => Row(
                          children: [Text(number[0]), Text(number[1])],
                        ))
                    .toList(),
              );
            }
            return Text("No Image Currently Selected");
          }),
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: roleController,
                decoration: InputDecoration(labelText: "Enter the role"),
              ),
            ),
            Expanded(
              child: TextField(
                controller: numberController,
                decoration: InputDecoration(labelText: "Enter the number"),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                onNumberAdd(roleController.text, numberController.text,
                    BlocProvider.of<CreateHotelCubit>(context));
              },
              label: Text("Add Number"),
              icon: Icon(Icons.add),
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            BlocProvider.of<CreateHotelCubit>(context).createHotel();
            Navigator.of(context).popAndPushNamed("/");
          },
          child: Text("Create Hotel"),
        ),
      ],
    );
  }

  Future<void> onNumberAdd(
      String role, String number, CreateHotelCubit createHotelCubit) async {
    createHotelCubit.addHotelPhoneNumber(role, number);
  }
}
