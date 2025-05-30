import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HotelBooking extends StatefulWidget {
  const HotelBooking({super.key});

  @override
  State<HotelBooking> createState() => _HotelBookingState();
}

class _HotelBookingState extends State<HotelBooking> {
  final supabase = Supabase.instance.client;

  bool isLoading = true;

  String? error;

  DateTime? checkInDate;
  DateTime? checkOutDate;
  late String imageUrl;
  List<String> ImageUrls = [];
  List<dynamic> hotelName = [];
  List<dynamic>  hotelDescription = [];
  List<dynamic> price = [];

  final String bookingId = '224c4f8c-e525-4dd0-ad6b-f2ccd16e1143';
  final String managerId = 'e8b2c4e6-353a-450d-ab3a-08a0676fd773';
  final String roomId = '660e8400-e29b-41d4-a716-446655440001';


  @override
  void initState() {
    super.initState();
    fetchRoomBookingDetails();
    fetchHotelName();
    fetchHotelDescription();
    fetchPrices();
  }

  Future<void> fetchRoomBookingDetails() async {
    try {
      final response = await supabase
          .from('room_booking')
          .select('check_in, check_out')
          .eq('id', bookingId)
          .limit(1)
          .maybeSingle();

      final imageNetworkData = await supabase.rpc("get_booking_room_image",
          params: {"room_booking_id": bookingId}).single();

      var newImageUrl = await supabase.storage
          .from("roomimages")
          .createSignedUrl(imageNetworkData["file"], 60 * 60 * 60);

       final imagesData = await supabase.rpc("get_booking_room_images",
          params: {"room_booking_id": bookingId});


        List<String> newImageUrls= [];
        

        for(var idata in imagesData){

         // print(idata["file"]);
        
           var newImageUrl = await supabase.storage
          .from("roomimages")
          .createSignedUrl(idata["file"], 60 * 60 * 60);

          newImageUrls.add(newImageUrl);


        //print(newImagesUrl);
        }
        

        
      setState(() {
         ImageUrls=newImageUrls;
      });

      //print(imageList);
         // (imagesData[0]["file"]);
      
        




      if (response != null && newImageUrl.isNotEmpty) {
        setState(() {
          checkInDate = DateTime.parse(response['check_in']);
          checkOutDate = DateTime.parse(response['check_out']);
          imageUrl = newImageUrl;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = 'Booking fetch error: $e';
      });
    }
  }

  String formatDateTime(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
  

    Future<void> fetchHotelName() async {
    try {
      final response = await supabase
          .from('hotel')
          .select('name')
          .eq('manager_id', managerId);

          setState(() {
        hotelName = response;
      });


    } catch (e) {
      setState(() {
        error = 'Hotel name fetch error: $e';
      });
    }
  }



 Future<void> fetchHotelDescription() async {
    try {
      final response = await supabase
          .from('hotel_room')
          .select('description')
          .eq('id', roomId);

          setState(() {
        hotelDescription = response;
      });


    } catch (e) {
      setState(() {
        error = 'Hotel name fetch error: $e';
      });
    }
  }



  Future<void> fetchPrices() async {
    try {
      final response = await supabase.from('hotel_room').select().eq('id', roomId);

     
      setState(() {
        price = response;
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










   

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return inLoading();
    } else {
      return inLoaded();
    }
  }

  Widget inLoading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 20),
          Text("Loading booking details..."),
        ],
      ),
    );
  }

  Widget inLoaded() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hotel Details"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imageUrl,
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: MediaQuery.of(context).size.height * 0.35,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 242, 32, 32),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 5,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.location_on, size: 20, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        "MAP",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Room & Guest Details
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Check-in",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(checkInDate != null
                          ? formatDateTime(checkInDate!)
                          : "Loading..."),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text("Check-out",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(checkOutDate != null
                          ? formatDateTime(checkOutDate!)
                          : "Loading..."),
                    ],
                  ),
                 
                ],
              ),

              const Divider(thickness: 1),
              const SizedBox(height: 8),

              const Center(
                child: Text("ROOMS",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 8),

              CarouselSlider(
                options: CarouselOptions(
                  height: 200,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                ),
                items: ImageUrls.map((item) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      item,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 16),
             Text(
                   hotelName.isNotEmpty ? hotelName[0]['name'] : "Loading hotel name...",
             style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              const SizedBox(height: 4),
              Text(
                   hotelDescription.isNotEmpty ? hotelDescription[0]['description'] : "Loading hotel Description...",
             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),),
              const SizedBox(height: 20),

              const Text("Best Available Rate",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 10),
             Text(
                  price.isNotEmpty ? price[0]['price'].toString() : "Loading price...",),

                 const SizedBox(height: 20),
             





                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Icon(Icons.bed, color: Colors.black54),
                      const SizedBox(width: 4),
                      const Text(
                        "1 BED / EXTRA BED AVAILABLE",
                        style: TextStyle(fontSize: 10, color: Colors.black54),
                      ),
                    ],
                  ),

                  // Up to 3 Guests
                  Column(
                    children: [
                      Icon(Icons.person, color: Colors.black54),
                      const SizedBox(width: 4),
                      const Text(
                        "UP TO 3 GUESTS",
                        style: TextStyle(fontSize: 10, color: Colors.black54),
                      ),
                    ],
                  ),

                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 24, 108, 219),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      "details",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 40,
              ),













             

              const SizedBox(height: 40),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 30, 4, 226),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Book again",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
