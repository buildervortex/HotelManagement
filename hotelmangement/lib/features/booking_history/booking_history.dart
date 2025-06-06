import 'package:flutter/material.dart';
import 'package:hotelmangement/features/booking_history/booking_calendar.dart';
import 'package:hotelmangement/features/booking_history/hotel_booking_history.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final supabase = Supabase.instance.client;

  bool isLoading = true;
  String? error;

  DateTime? checkInDate;

  final String hotelId = '550e8400-e29b-41d4-a716-446655440002';
  final String bookingId = '224c4f8c-e525-4dd0-ad6b-f2ccd16e1143';
  final String managerId = 'e8b2c4e6-353a-450d-ab3a-08a0676fd773';

  List<Map<String, dynamic>> bookings = [
  {
      "image": "assets/booking_history/hotel4.jpg",
      "name": "Ocean View Hotel",
     
      "date": "5 March 2023",
   
      "price": "\$150",
    },
    {
      "image": "assets/booking_history/hotel3.jpg",
      "name": "Historic Manor Inn",
     
      "date": "5 March 2023",
  
      "price": "\$150",
    },
    {
      "image": "assets/booking_history/hotel1.jpg",
      "name": "Heden Golf",
    
      "date": "23 July 2019",
 
      "price": "\$127",
    },
    {
      "image": "assets/booking_history/hotel2.jpg",
      "name": "Sunset Resort",
    
      "date": "12 June 2021",
    
      "price": "\$99",
    },
    {
      "image": "assets/booking_history/hotel5.jpg",
      "name": "Urban Boutique Hotel",
    
      "date": "5 March 2023",
     
      "price": "\$150",
    },


  ];

  @override
  void initState() {
    super.initState();
    fetchPrices();
    fetchRoomBookingDetails();
    fetchHotelName();
  }

  Future<void> fetchPrices() async {
    try {
      final response =
          await supabase.from('hotel_room').select().eq('hotel_id', hotelId);

      final updatedBookings = [...bookings];
      for (int i = 0; i < updatedBookings.length && i < response.length; i++) {
        if (response[i]['price'] != null) {
          updatedBookings[i]['price'] = "\$${response[i]['price']}";
        }
      }

      setState(() {
        bookings = updatedBookings;
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

  Future<void> fetchRoomBookingDetails() async {
    try {
      final response = await supabase
          .from('room_booking')
          .select('check_in, check_out')
          .eq('id', bookingId)
        
          .maybeSingle();

      final imageNetworkData = await supabase.rpc("get_booking_room_image",
          params: {"room_booking_id": bookingId});

      var newImageUrl = await supabase.storage
          .from("roomimages")
        .createSignedUrl(imageNetworkData["file"].toString(), 60 * 60 * 60);


      if (response != null && bookings.isNotEmpty) {
        setState(() {
          checkInDate = DateTime.parse(response['check_in']);
          bookings[0]["date"] = formatDateTime(checkInDate!);
          bookings[0]["image"] = newImageUrl; // network image
        });
      }
    } catch (e) {
      setState(() {
        error = 'Booking fetch error: $e';
      });
    }
  }

  Future<void> fetchHotelName() async {
    try {
      final response = await supabase
          .from('hotel')
          .select('name')
          .eq('manager_id', managerId);

      if (response != null && response is List && response.isNotEmpty) {
        setState(() {
          bookings[0]['name'] = response[0]['name'];
        });
      }
    } catch (e) {
      setState(() {
        error = 'Hotel name fetch error: $e';
      });
    }
  }

  String formatDateTime(DateTime dateTime) {
    return "${dateTime.day}/${dateTime.month}/${dateTime.year}, "
        "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double textScale = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Booking History",
          style: TextStyle(color: Colors.black, fontSize: 20 * textScale),
        ),
        backgroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                bookings.clear();
              });
            },
            child: Text(
              "Clear All",
              style: TextStyle(color: Colors.red, fontSize: 16 * textScale),
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: Text(
                      "Hotels",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16 * textScale,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BookingCalendar()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                    ),
                    child: Text("Date",
                        style: TextStyle(fontSize: 16 * textScale)),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            if (error != null)
              Text(error!, style: TextStyle(color: Colors.red)),
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : bookings.isEmpty
                      ? Center(child: Text("No bookings available"))
                      : ListView.builder(
                          itemCount: bookings.length,
                          itemBuilder: (context, index) {
                            var booking = bookings[index];
                            return Dismissible(
                              key: UniqueKey(),
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) {
                                setState(() {
                                  bookings.removeAt(index);
                                });
                              },
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Icon(Icons.delete, color: Colors.white),
                              ),
                              child: Card(
                                margin: EdgeInsets.only(bottom: 10),
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(screenWidth * 0.04),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: booking["image"]
                                                .toString()
                                                .startsWith("http")
                                            ? Image.network(
                                                booking["image"],
                                                width: screenWidth * 0.3,
                                                height: 100,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.asset(
                                                booking["image"],
                                                width: screenWidth * 0.3,
                                                height: 100,
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                      SizedBox(width: screenWidth * 0.05),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              booking["name"],
                                              style: TextStyle(
                                                fontSize: 12 * textScale,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                                height: screenHeight * 0.01),
                                            SizedBox(
                                                height: screenHeight * 0.01),
                                            Text(
                                              "Date: ${booking["date"]}",
                                              style: TextStyle(
                                                  fontSize: 10 * textScale),
                                            ),
                                            Text(
                                              booking["price"].toString(),
                                              style: TextStyle(
                                                fontSize: 10 * textScale,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      TextButton(
                                        child: const Text('Booking Now',
                                            style: TextStyle(fontSize: 10)),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const HotelBooking()),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
