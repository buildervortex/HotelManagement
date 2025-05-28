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
  bool isLoading = true;
  String? error;

  DateTime? checkInDate;
  DateTime? checkOutDate;

  final String hotelId = '550e8400-e29b-41d4-a716-446655440001';
  final String bookingId = '880e8400-e29b-41d4-a716-446655440002';

  @override
  void initState() {
    super.initState();
    fetchHotelPhoneNumbers();
    fetchRoomBookingDetails();
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
          .limit(1)
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
            buildRow("No. of Adults", "2", normalStyle),
            buildRow("No. of Children", "2", normalStyle),
            buildRow("No. of Rooms", "1", normalStyle),
            const Divider(height: 32),
            buildRow("Price", "\$125", normalStyle),
            buildRow("Tax", "\$20", normalStyle),
            buildRow("Total", "\$145", boldStyle),
            const Divider(height: 32),
            Row(children: [Text("Food details", style: boldStyle)]),
            const SizedBox(height: 16),
            buildRow("Bagels with turkey and bacon", "\$10", normalStyle),
            buildRow("Sandwich", "\$5", normalStyle),
            const Divider(height: 32),
            buildRow("Subtotal", "\$15", normalStyle),
            buildRow("Service tax", "\$2", normalStyle),
            const Divider(height: 32),
            buildRow("Total", "\$17", boldStyle),
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
