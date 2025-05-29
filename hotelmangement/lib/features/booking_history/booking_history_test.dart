// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class History extends StatefulWidget {
//   const History({super.key});

//   @override
//   State<History> createState() => _HistoryState();
// }

// class _HistoryState extends State<History> {
//   final supabase = Supabase.instance.client;
  
//   bool isLoading = true;
//   String? error;

//   DateTime? checkInDate;
//    late String imageUrl;

//   final String hotelId = '550e8400-e29b-41d4-a716-446655440002';
//   final String bookingId = '224c4f8c-e525-4dd0-ad6b-f2ccd16e1143';
//   final String managerId = 'e8b2c4e6-353a-450d-ab3a-08a0676fd773';

//   @override
//   void initState() {
//     super.initState();
//     fetchPrices();
//     fetchRoomBookingDetails();
//     fetchHotelName();
//   }

//   Future<void> fetchPrices() async {
//     try {
//       final response = await supabase.from('hotel_room').select().eq('hotel_id', hotelId);

//       final updatedBookings = [...bookings];
//       for (int i = 0; i < updatedBookings.length && i < response.length; i++) {
//         if (response[i]['price'] != null) {
//           updatedBookings[i]['price'] = "\$${response[i]['price']}";
//         }
//       }

//       setState(() {
//         bookings = updatedBookings;
//       });
//     } catch (e) {
//       setState(() {
//         error = 'Price fetch error: $e';
//       });
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   Future<void> fetchRoomBookingDetails() async {
//     try {
//       final response = await supabase
//           .from('room_booking')
//           .select('check_in, check_out')
//           .eq('id', bookingId)
//           .limit(1)
//           .maybeSingle();



//       final imageNetworkData = await supabase.rpc("get_booking_room_image",
//           params: {"room_booking_id": bookingId}).single();

//         var newImageUrl = await supabase.storage
//           .from("roomimages")
//           .createSignedUrl(imageNetworkData["file"], 60 * 60 * 60);



//       if (response != null && bookings.isNotEmpty) {
//         setState(() {
//           checkInDate = DateTime.parse(response['check_in']);
//           bookings[0]["date"] = formatDateTime(checkInDate!);
//         });
//       }
//     } catch (e) {
//       setState(() {
//         error = 'Booking fetch error: $e';
//       });
//     }
//   }

//   String formatDateTime(DateTime dateTime) {
//     return "${dateTime.day}/${dateTime.month}/${dateTime.year}, "
//         "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
//   }

//   Future<void> fetchHotelName() async {
//   try {
//     final response = await supabase
//         .from('hotel')
//         .select('name')
//         .eq('manager_id', managerId); // This returns a List

//     if (response != null && response is List && response.isNotEmpty) {
//       setState(() {
//         // Just use the first name for now, or loop if needed
//         bookings[0]['name'] = response[0]['name'];
//       });
//     }
//   } catch (e) {
//     setState(() {
//       error = 'Hotel name fetch error: $e';
//     });
//   }
// }



// List<Map<String, dynamic>> bookings = [
//     {
//       //"image": Image.network(bookings["image"]),
//       "name": "Loading...",
//       "rating": 3.9,
//       "reviews": 200,
//       "date": "Date unknown",
//       "discount": "25% OFF",
//       "price": "\$0",
//     },
//     {
//       "image": "assets/booking_history/hotel2.jpg",
//       "name": "Loading...",
//       "rating": 4.5,
//       "reviews": 320,
//       "date": "Date unknown",
//       "discount": "30% OFF",
//       "price": "\$0",
//     },
//     {
//       "image": "assets/booking_history/hotel5.jpg",
//       "name": "Loading...",
//       "rating": 4.2,
//       "reviews": 150,
//       "date": "Date unknown",
//       "discount": "20% OFF",
//       "price": "\$0",
//     },
//     {
//       "image": "assets/booking_history/hotel4.jpg",
//       "name": "Loading...",
//       "rating": 4.2,
//       "reviews": 150,
//       "date": "Date unknown",
//       "discount": "20% OFF",
//       "price": "\$0",
//     },
//     {
//       "image": "assets/booking_history/hotel3.jpg",
//       "name": "Loading...",
//       "rating": 4.2,
//       "reviews": 150,
//       "date": "Date unknown",
//       "discount": "20% OFF",
//       "price": "\$0",
//     },
//   ];









































//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;
//     double textScale = MediaQuery.of(context).textScaleFactor;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Booking History",
//           style: TextStyle(color: Colors.black, fontSize: 20 * textScale),
//         ),
//         backgroundColor: Colors.white,
//         actions: [
//           TextButton(
//             onPressed: () {
//               setState(() {
//                 bookings.clear();
//               });
//             },
//             child: Text(
//               "Clear All",
//               style: TextStyle(color: Colors.red, fontSize: 16 * textScale),
//             ),
//           )
//         ],
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(screenWidth * 0.04),
//         child: Column(
//           children: [
//             TextField(
//               decoration: InputDecoration(
//                 hintText: "Search",
//                 prefixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//             SizedBox(height: screenHeight * 0.02),
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//                     child: Text(
//                       "Hotels",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16 * textScale,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.white,
//                       foregroundColor: Colors.black,
//                     ),
//                     child: Text("Date", style: TextStyle(fontSize: 16 * textScale)),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: screenHeight * 0.02),
//             if (error != null)
//               Text(error!, style: TextStyle(color: Colors.red)),
//             Expanded(
//               child: isLoading
//                   ? Center(child: CircularProgressIndicator())
//                   : bookings.isEmpty
//                       ? Center(child: Text("No bookings available"))
//                       : ListView.builder(
//                           itemCount: bookings.length,
//                           itemBuilder: (context, index) {
//                             var booking = bookings[index];
//                             return Dismissible(
//                               key: UniqueKey(),
//                               direction: DismissDirection.endToStart,
//                               onDismissed: (direction) {
//                                 setState(() {
//                                   bookings.removeAt(index);
//                                 });
//                               },
//                               background: Container(
//                                 color: Colors.red,
//                                 alignment: Alignment.centerRight,
//                                 padding: EdgeInsets.symmetric(horizontal: 20),
//                                 child: Icon(Icons.delete, color: Colors.white),
//                               ),
//                               child: Card(
//                                 margin: EdgeInsets.only(bottom: 10),
//                                 elevation: 4,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 child: Padding(
//                                   padding: EdgeInsets.all(screenWidth * 0.04),
//                                   child: Row(
//                                     children: [
//                                       ClipRRect(
//                                         borderRadius: BorderRadius.circular(8),
//                                         child: Image.asset(
//                                           booking["image"],
//                                           width: screenWidth * 0.3,
//                                         ),
//                                       ),
//                                       SizedBox(width: screenWidth * 0.05),
//                                       Expanded(
//                                         child: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               booking["name"],
//                                               style: TextStyle(
//                                                 fontSize: 12 * textScale,
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                             ),
//                                             SizedBox(height: screenHeight * 0.01),
//                                             Row(
//                                               children: [
//                                                 Icon(Icons.star, color: Colors.amber, size: 10),
//                                                 Text(
//                                                   " ${booking["rating"]} (${booking["reviews"]} reviews)",
//                                                   style: TextStyle(fontSize: 10 * textScale),
//                                                 ),
//                                               ],
//                                             ),
//                                             SizedBox(height: screenHeight * 0.01),
//                                             Text(
//                                               "Date: ${booking["date"]}",
//                                               style: TextStyle(fontSize: 10 * textScale),
//                                             ),
//                                             Text(
//                                               "Discount: ${booking["discount"]}",
//                                               style: TextStyle(
//                                                 color: Colors.green,
//                                                 fontSize: 10 * textScale,
//                                               ),
//                                             ),
//                                             Text(
//                                               booking["price"].toString(),
//                                               style: TextStyle(
//                                                 fontSize: 10 * textScale,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Colors.blue,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       TextButton(
//                                         child: const Text('Booking Now', style: TextStyle(fontSize: 10)),
//                                         onPressed: () {},
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
