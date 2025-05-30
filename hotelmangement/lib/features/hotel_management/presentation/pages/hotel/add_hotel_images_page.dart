import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelmangement/features/hotel_management/presentation/blocs/hotels/cubit/create_hotel_cubit.dart';

class AddHotelImagesPage extends StatefulWidget {
  const AddHotelImagesPage({super.key});

  @override
  State<AddHotelImagesPage> createState() => _AddHotelImagesPageState();
}

class _AddHotelImagesPageState extends State<AddHotelImagesPage> {
  @override
  Widget build(BuildContext context) {
    print(BlocProvider.of<CreateHotelCubit>(context).state);
    return Placeholder();
  }
}
