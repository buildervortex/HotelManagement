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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Hotel"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Enter Hotel Details",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: hotelNameController,
                  decoration: const InputDecoration(
                    labelText: "Enter the hotel name",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.hotel),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: hotelAddressController,
                  decoration: const InputDecoration(
                    labelText: "Enter the address name",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.location_on),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      BlocProvider.of<CreateHotelCubit>(context)
                          .setHotelDetails(
                        hotelNameController.text,
                        hotelAddressController.text,
                        widget.managerId,
                      );
                      Navigator.of(context).pushNamed("/getLocation");
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    child: const Text("Next"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
