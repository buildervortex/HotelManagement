import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DisplayHotelDetails extends StatefulWidget {
  const DisplayHotelDetails({super.key});

  @override
  State<DisplayHotelDetails> createState() => _DisplayHotelDetailsState();
}

class _DisplayHotelDetailsState extends State<DisplayHotelDetails> {
  final supabase = Supabase.instance.client;

  List<Hotel> hotels = [];

  @override
  void initState() {
    super.initState();
    _loadHotels();
  }

  void _loadHotels() async {
    final hotelList = await supabase.from("hotel").select();
    setState(() {
      hotels = hotelList.map((hotel) => Hotel.fromJson(hotel)).toList();
    });
    print(hotels);
    print(hotelList);
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hotel Room Prices")),
      body: ListView.builder(
        itemCount: hotels.length,
        itemBuilder: (context, index) {
          final hotel = hotels[index];
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text(hotel.name),
              subtitle: Text("Address: ${hotel.address}"),
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
