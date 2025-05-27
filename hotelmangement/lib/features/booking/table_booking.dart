import 'package:flutter/material.dart';

class TableBookingPage extends StatefulWidget {
  @override
  _TableBookingPageState createState() => _TableBookingPageState();
}

class _TableBookingPageState extends State<TableBookingPage> {
  final _formKey = GlobalKey<FormState>();
  String customerName = '';
  String contactNumber = '';
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  int guests = 1;
  String specialRequest = '';

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => selectedDate = picked);
  }

  Future<void> _pickTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) setState(() => selectedTime = picked);
  }

  void _submitBooking() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Booking logic placeholder (e.g., send to server)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Table booked successfully!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Table Booking"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text("Book a Table",
                  style: Theme.of(context).textTheme.titleLarge),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(labelText: 'Customer Name'),
                validator: (value) => value!.isEmpty ? 'Enter name' : null,
                onSaved: (value) => customerName = value!,
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: 'Contact Number'),
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    value!.isEmpty ? 'Enter contact number' : null,
                onSaved: (value) => contactNumber = value!,
              ),
              SizedBox(height: 10),
              ListTile(
                title: Text(
                    "Date: ${selectedDate.toLocal().toString().split(' ')[0]}"),
                trailing: Icon(Icons.calendar_today),
                onTap: () => _pickDate(context),
              ),
              ListTile(
                title: Text("Time: ${selectedTime.format(context)}"),
                trailing: Icon(Icons.access_time),
                onTap: () => _pickTime(context),
              ),
              DropdownButtonFormField<int>(
                decoration: InputDecoration(labelText: 'Number of Guests'),
                value: guests,
                items: List.generate(10, (index) => index + 1)
                    .map((e) => DropdownMenuItem(value: e, child: Text('$e')))
                    .toList(),
                onChanged: (value) => setState(() => guests = value!),
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: 'Special Requests'),
                maxLines: 3,
                onSaved: (value) => specialRequest = value ?? '',
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitBooking,
                child: Text("Book Table"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
