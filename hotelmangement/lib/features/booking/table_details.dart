import 'package:flutter/material.dart';

class StaticBookingDetailsPage extends StatelessWidget {
  // Static example data
  final String customerName = "John Doe";
  final String contactNumber = "123-456-7890";
  final DateTime bookingDate = DateTime(2025, 6, 15);
  final TimeOfDay bookingTime = TimeOfDay(hour: 19, minute: 30);
  final int guests = 4;
  final String specialRequests = "Window seat, please";

  @override
  Widget build(BuildContext context) {
    final dateStr = '${bookingDate.toLocal()}'.split(' ')[0];
    final timeStr = bookingTime.format(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Details'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DetailRow(label: 'Customer Name', value: customerName),
                      DetailRow(label: 'Contact Number', value: contactNumber),
                      DetailRow(label: 'Date', value: dateStr),
                      DetailRow(label: 'Time', value: timeStr),
                      DetailRow(label: 'Number of Guests', value: '$guests'),
                      DetailRow(
                        label: 'Special Requests',
                        value: specialRequests.isNotEmpty
                            ? specialRequests
                            : 'None',
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Booking confirmed!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  textStyle: TextStyle(fontSize: 18),
                ),
                child: Text('Confirm Booking'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const DetailRow({Key? key, required this.label, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.teal,
            ),
          ),
          SizedBox(height: 4),
          Text(value, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
