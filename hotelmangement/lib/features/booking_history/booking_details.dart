import 'package:flutter/material.dart';


class BookingDetails extends StatefulWidget {
  const BookingDetails({super.key});

  @override
  State<BookingDetails> createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final baseFontSize = screenWidth * 0.040; // adjusts based on screen width
    final boldStyle = TextStyle(fontSize: baseFontSize, fontWeight: FontWeight.bold);
    final normalStyle = TextStyle(fontSize: baseFontSize);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking details"),
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
            buildRow("Checkin date & time", "23 July 2019, 10:00 AM", normalStyle),
            buildRow("Checkout date & time", "25 July 2019, 10:00 AM", normalStyle),
            buildRow("No. of Adults", "2", normalStyle),
            buildRow("No. of Children", "2", normalStyle),
            buildRow("No. of room", "1", normalStyle),
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
            buildRow("Sub total", "\$15", normalStyle),
            buildRow("Service tax", "\$2", normalStyle),
            const Divider(height: 32),
            buildRow("Total", "\$17", boldStyle),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 50, 98, 243),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
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
