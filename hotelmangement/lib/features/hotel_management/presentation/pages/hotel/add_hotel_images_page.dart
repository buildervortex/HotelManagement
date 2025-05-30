import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelmangement/features/hotel_management/presentation/blocs/hotels/cubit/create_hotel_cubit.dart';
import 'package:image_picker/image_picker.dart';

class AddHotelImagesPage extends StatefulWidget {
  const AddHotelImagesPage({super.key});

  @override
  State<AddHotelImagesPage> createState() => _AddHotelImagesPageState();
}

class _AddHotelImagesPageState extends State<AddHotelImagesPage> {
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<CreateHotelCubit, CreateHotelState>(
            builder: (conte, state) {
          if (state is CreateHotelImageAdded) {
            return Column(
              children: state.images
                  .map((image) => Row(
                        children: [
                          Image.file(File(image)),
                          Text("File is $image")
                        ],
                      ))
                  .toList(),
            );
          }
          return Text("No Image Currently Selected");
        }),
        ElevatedButton.icon(
          onPressed: () {
            onImagePick(ImageSource.gallery,
                BlocProvider.of<CreateHotelCubit>(context));
          },
          label: Text("Take Image"),
          icon: Icon(Icons.camera),
        ),
      ],
    );
  }

  Future<void> onImagePick(
      ImageSource source, CreateHotelCubit createHotelCubit) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      createHotelCubit.addHotelImages(pickedFile.path);
    }
  }
}
