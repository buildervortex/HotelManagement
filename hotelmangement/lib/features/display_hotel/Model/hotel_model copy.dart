import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DisplayHotelDetails extends StatefulWidget {
  const DisplayHotelDetails({super.key});

  @override
  State<DisplayHotelDetails> createState() => _DisplayHotelDetailsState();
}

class _DisplayHotelDetailsState extends State<DisplayHotelDetails> {
  final supabase = Supabase.instance.client;

  List<dynamic> prices = [];
  bool isLoading = true;
  String? error;

  final String hotelId = '550e8400-e29b-41d4-a716-446655440002';

  @override
  void initState() {
    super.initState();
    fetchPrices();
  }

  Future<void> fetchPrices() async {
    try {
         final hotel_list = await supabase
          .from("hotel_phone_number")
          .select()
          .eq("hotel_id", "")
          .single();
      print(hotel_list);
      final response =
          await supabase.from('hotel_room').select().eq('hotel_id', hotelId);

   

      setState(() {
        prices = response;
      });
    } catch (e) {
      setState(() {
        error = 'Price fetch error: $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> TestRun() async {
    final hotel_list = await supabase
        .from("hotel_phone_number")
        .select()
        .eq("hotel_id", "")
        .single();
    print(hotel_list);
  }

  @override
  Widget build(BuildContext context) {
    TestRun();
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (error != null) {
      return Scaffold(
        body: Center(child: Text(error!)),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Hotel Room Prices")),
      body: ListView.builder(
        itemCount: prices.length,
        itemBuilder: (context, index) {
          final room = prices[index];
          final price = room['price'] ?? 'N/A';
          final roomType = room['room_type'] ?? 'Room ${index + 1}';
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text(roomType),
              subtitle: Text('Price: \$${price.toString()}'),
            ),
          );
        },
      ),
    );
  }
}

// ----------------- Model and Dummy List ------------------

class HotelModel {
  final String name, image, description, package, location, category;
  final double rating;
  final int review, price, bed, bathroom, Mobile;
  List<String> Facilities;

  HotelModel({
    required this.name,
    required this.image,
    required this.description,
    required this.package,
    required this.location,
    required this.rating,
    required this.review,
    required this.price,
    required this.bed,
    required this.bathroom,
    required this.Mobile,
    required this.Facilities,
    required this.category,
  });
}

List<HotelModel> hotelModel = [
  HotelModel(
    name: "Aventra Hotel",
    image: "assets/hotels/hilton.jpg",
    location: "Colombo 07",
    rating: 4.7,
    review: 1200,
    price: 3500,
    description:
        "A luxurious stay with modern amenities and breathtaking views in the heart of the city.",
    package: "Day",
    bed: 3,
    bathroom: 4,
    Mobile: 0777123456,
    Facilities: ["AC", "Restaurant", "Swimming Pool", "24 Hours Front Desk"],
    category: "Resorts",
  ),
  HotelModel(
    name: "Grand Ocean Hotel",
    image: "assets/hotels/hilton.jpg",
    location: "Galle Face, Colombo",
    rating: 4.6,
    review: 980,
    price: 3200,
    description:
        "Enjoy a beachfront retreat with world-class service and exquisite dining options.",
    package: "Night",
    bed: 2,
    bathroom: 3,
    Mobile: 0777123457,
    Facilities: ["AC", "Restaurant", "Beach Access", "Bar"],
    category: "Resorts",
  ),
  HotelModel(
    name: "Serene Paradise Hotel",
    image: "assets/hotels/hilton.jpg",
    location: "Kandy Hills",
    rating: 4.8,
    review: 1500,
    price: 4000,
    description:
        "A peaceful getaway surrounded by lush greenery and scenic mountain views.",
    package: "Weekend",
    bed: 4,
    bathroom: 5,
    Mobile: 0777123458,
    Facilities: ["AC", "Restaurant", "Swimming Pool", "Gym"],
    category: "Villas",
  ),
];
