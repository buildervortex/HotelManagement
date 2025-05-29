import 'package:flutter/material.dart';

class BookingDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Room Booking Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text("Floor: 2nd", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text("Room Number: 202", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text("Guests: 3", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text("Check-in: June 10, 2025", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text("Check-out: June 15, 2025", style: TextStyle(fontSize: 18)),
            SizedBox(height: 30),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Room booked successfully!")),
                  );
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Text("Book Now", style: TextStyle(fontSize: 18)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
