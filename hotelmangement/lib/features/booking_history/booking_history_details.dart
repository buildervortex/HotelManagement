import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BookingDetails extends StatefulWidget {
  const BookingDetails({super.key});

  @override
  State<BookingDetails> createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  final supabase = Supabase.instance.client;

  List<dynamic> phoneNumbers = [];
   List<dynamic> price = [];
  
  bool isLoading = true;
  String? error;

  DateTime? checkInDate;
  DateTime? checkOutDate;
  

  final String hotelId = '550e8400-e29b-41d4-a716-446655440001';
  final String bookingId = '880e8400-e29b-41d4-a716-446655440002';
  final String roomId= '660e8400-e29b-41d4-a716-446655440001';

  @override
  void initState() {
    super.initState();
    fetchHotelPhoneNumbers();
    fetchRoomBookingDetails();
    fetchPrices();
  }

  Future<void> fetchHotelPhoneNumbers() async {
    try {
      final response = await supabase
          .from('hotel_phone_number')
          .select()
          .eq('hotel_id', hotelId);

      setState(() {
        phoneNumbers = response;
      });
    } catch (e) {
      setState(() {
        error = 'Phone fetch error: $e';
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
          .eq('booking_id', bookingId)
          .maybeSingle();
      

      if (response != null) {
        setState(() {
          checkInDate = DateTime.parse(response['check_in']);
          checkOutDate = DateTime.parse(response['check_out']);
        });
      }
    } catch (e) {
      setState(() {
        error = 'Booking fetch error: $e';
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





  String formatDateTime(DateTime dateTime) {
    return "${dateTime.day}/${dateTime.month}/${dateTime.year}, "
        "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final baseFontSize = screenWidth * 0.040;
    final boldStyle =
        TextStyle(fontSize: baseFontSize, fontWeight: FontWeight.bold);
    final normalStyle = TextStyle(fontSize: baseFontSize);

    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (error != null) {
      return Scaffold(
        body: Center(child: Text("Error: $error")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking Details"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(children: [Text("Room details", style: boldStyle)]),
            const SizedBox(height: 16),
            buildRow(
              "Checkin date & time",
              checkInDate != null
                  ? formatDateTime(checkInDate!)
                  : "Loading...",
              normalStyle,
            ),
            buildRow(
              "Checkout date & time",
              checkOutDate != null
                  ? formatDateTime(checkOutDate!)
                  : "Loading...",
              normalStyle,
            ),
           
            const Divider(height: 32),
           
           buildRow(
                  "Room Price",
                   price.isNotEmpty
                  ? price.map((p) => "\$${p['price']}").join(", ")
                 : "No data",
                 boldStyle,
                 ),

            const Divider(height: 32),
            Row(children: [Text("Food details", style: boldStyle)]),
            
          
            buildRow("Total food Price", "\$17", boldStyle),
            const SizedBox(height: 30),
             const Divider(height: 32),
            buildRow("Total Price", "\$17", boldStyle),
            const SizedBox(height: 30),

            Row(children: [Text("Phone Numbers", style: boldStyle)]),
            const SizedBox(height: 10),
            ...phoneNumbers.map((phone) => buildRow(
                  phone['role'] ?? 'Unknown Role',
                  phone['number'] ?? 'N/A',
                  normalStyle,
                )),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Implement booking logic or redirection
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 50, 98, 243),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                  ),
                  child: Text("Book again", style: TextStyle(fontSize: baseFontSize)),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRow(String label, String value, TextStyle style) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(label, style: style)),
          Text(value, style: style),
        ],
      ),
    );
  }
}
