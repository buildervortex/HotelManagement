import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RoomBookingPage extends StatefulWidget {
  @override
  _RoomBookingPageState createState() => _RoomBookingPageState();
}

class _RoomBookingPageState extends State<RoomBookingPage> {
  DateTime? checkInDate;
  DateTime? checkOutDate;
  int guests = 1;
  String selectedFloor = '1st';
  String selectedRoom = '101';

  final List<String> floorOptions = ['1st', '2nd', '3rd'];
  final List<String> roomOptions = ['101', '102', '201', '202', '301', '302'];
  final List<String> roomPhotos = [
    'assets/booking/room1.jpg',
    'assets/booking/room2.jpg',
    'assets/booking/room3.jpg',
  ];

  Future<void> selectDate(BuildContext context, bool isCheckIn) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isCheckIn) {
          checkInDate = picked;
          if (checkOutDate != null && checkOutDate!.isBefore(picked)) {
            checkOutDate = picked.add(Duration(days: 1));
          }
        } else {
          checkOutDate = picked;
        }
      });
    }
  }

  void bookRoom() {
    if (checkInDate == null || checkOutDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please select both check-in and check-out dates."),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Booking Confirmed"),
        content: Text(
          "Floor: $selectedFloor\n"
          "Room: $selectedRoom\n"
          "Guests: $guests\n"
          "Check-in: ${DateFormat.yMd().format(checkInDate!)}\n"
          "Check-out: ${DateFormat.yMd().format(checkOutDate!)}",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Room Booking')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Room Photos",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            SizedBox(
              height: 130,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: roomPhotos.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        roomPhotos[index],
                        width: 200,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Text("Check-in Date"),
            ListTile(
              title: Text(
                checkInDate != null
                    ? DateFormat.yMMMMd().format(checkInDate!)
                    : "Select date",
              ),
              trailing: Icon(Icons.calendar_today),
              onTap: () => selectDate(context, true),
            ),
            Divider(),
            Text("Check-out Date"),
            ListTile(
              title: Text(
                checkOutDate != null
                    ? DateFormat.yMMMMd().format(checkOutDate!)
                    : "Select date",
              ),
              trailing: Icon(Icons.calendar_today),
              onTap: () => selectDate(context, false),
            ),
            Divider(),
            Text("Number of Guests"),
            Slider(
              value: guests.toDouble(),
              min: 1,
              max: 10,
              divisions: 9,
              label: guests.toString(),
              onChanged: (val) {
                setState(() {
                  guests = val.toInt();
                });
              },
            ),
            Divider(),
            Text("Select Floor"),
            DropdownButton<String>(
              value: selectedFloor,
              onChanged: (value) {
                setState(() {
                  selectedFloor = value!;
                });
              },
              items: floorOptions.map((floor) {
                return DropdownMenuItem(value: floor, child: Text(floor));
              }).toList(),
            ),
            Divider(),
            Text("Select Room Number"),
            DropdownButton<String>(
              value: selectedRoom,
              onChanged: (value) {
                setState(() {
                  selectedRoom = value!;
                });
              },
              items: roomOptions.map((room) {
                return DropdownMenuItem(value: room, child: Text(room));
              }).toList(),
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: bookRoom,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  child: Text("Book Now",
                      style: TextStyle(fontSize: 18, color: Colors.blueAccent)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
