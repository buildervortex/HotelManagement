import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DisplayHotelDetails extends StatefulWidget {
  const DisplayHotelDetails({super.key});

  @override
  State<DisplayHotelDetails> createState() => _DisplayHotelDetailsState();
}

class _DisplayHotelDetailsState extends State<DisplayHotelDetails> {
  final supabase = Supabase.instance.client;

  List<ExtendedHotel> extendedHotels = [];

  @override
  void initState() {
    super.initState();
    _loadHotels();
  }

  void _loadHotels() async {
    final hotelList = await supabase.from("hotel").select();
    List<Hotel> hotels = [];
    List<ExtendedHotel> extHotel = [];

    hotels = hotelList.map((hotel) => Hotel.fromJson(hotel)).toList();
    for (Hotel hotel in hotels) {
      final images =
          await supabase.from("hotel_image").select().eq("hotel_id", hotel.id);

      final phoneNumbers = await supabase
          .from("hotel_phone_number")
          .select()
          .eq("hotel_id", hotel.id);
      List<String> hotelImageUrlList = [];

      for (var image in images) {
        final url = await supabase.storage
            .from("hotelimage")
            .createSignedUrl(image["file"], 60 * 60 * 60);
        hotelImageUrlList.add(url);
      }

      extHotel.add(ExtendedHotel(
        hotel: hotel,
        phoneNumbers:
            phoneNumbers.map((num) => HotelPhoneNumber.fromJson(num)).toList(),
        hotelImageList: hotelImageUrlList,
      ));
    }

    setState(() {
      this.extendedHotels = extHotel;
    });
    print(hotels);
    print(hotelList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hotel Room Prices")),
      body: ListView.builder(
        itemCount: extendedHotels.length,
        itemBuilder: (context, index) {
          final hotel = extendedHotels[index];
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Column(
                children: [
                  // Text(hotel.hotelImageList.first ?? "No Image Available"),
                  Image.network(
                      extendedHotels[index].hotelImageList.first ?? ""),
                  Text(
                    hotel.hotel.name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    hotel.hotel.address,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              subtitle: Text("Address: ${hotel.phoneNumbers.first.number}"),
            ),
          );
        },
      ),
    );
  }
}

class Hotel {
  final String id;
  final String managerId;
  final String name;
  final String address;
  final double longitude;
  final double latitude;
  final String? mainImage;
  final DateTime? createdAt;

  const Hotel({
    required this.id,
    required this.managerId,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    this.mainImage,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      longitude: (json['longitude'] as num).toDouble(),
      latitude: (json['latitude'] as num).toDouble(),
      managerId: json['manager_id'] as String,
      mainImage: json['mainimage'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}

class HotelImage {
  final String id;
  final String hotelId;
  final String file;

  const HotelImage({
    required this.id,
    required this.hotelId,
    required this.file,
  });

  factory HotelImage.fromJson(Map<String, dynamic> json) {
    return HotelImage(
      id: json['id'] as String,
      hotelId: json['hotel_id'] as String,
      file: json['file'] as String,
    );
  }
}

class HotelPhoneNumber {
  final String id;
  final String hotelId;
  final String number;
  final String role;

  const HotelPhoneNumber({
    required this.id,
    required this.hotelId,
    required this.number,
    required this.role,
  });

  factory HotelPhoneNumber.fromJson(Map<String, dynamic> json) {
    return HotelPhoneNumber(
      id: json['id'] as String,
      hotelId: json['hotel_id'] as String,
      number: json['number'] as String,
      role: json['role'] as String,
    );
  }
}

class ExtendedHotel {
  final Hotel hotel;
  final List<HotelPhoneNumber> phoneNumbers;
  final List<String> hotelImageList;

  const ExtendedHotel({
    required this.hotel,
    required this.phoneNumbers,
    required this.hotelImageList,
  });
}
