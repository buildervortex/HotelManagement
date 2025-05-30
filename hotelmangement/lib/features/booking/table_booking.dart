import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TableBookingPage extends StatefulWidget {
  final String bookingId;

  TableBookingPage({required this.bookingId});

  @override
  _TableBookingPageState createState() => _TableBookingPageState();
}

class _TableBookingPageState extends State<TableBookingPage> {
  final _formKey = GlobalKey<FormState>();

  // Form fields
  String customerName = '';
  String contactNumber = '';
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  int guests = 1;
  String specialRequest = '';

  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    _fetchBookingData();
  }

  Future<void> _fetchBookingData() async {
    try {
      final data = await supabase
          .from('table_booking')
          .select()
          .eq('id', widget.bookingId)
          .single();

      if (data != null) {
        final reservedDate = DateTime.parse(data['reserved_datetime']);

        setState(() {
          selectedDate = reservedDate;
          selectedTime = TimeOfDay.fromDateTime(reservedDate);
          customerName = data['customer_name'] ?? '';
          contactNumber = data['contact_number'] ?? '';
          guests = data['guests'] ?? 1;
          specialRequest = data['special_request'] ?? '';
        });
      }
    } catch (e) {
      print('Error fetching booking: $e');
    }
  }

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

  void _submitBooking() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final DateTime fullDateTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );

      await supabase.from('table_booking').update({
        'reserved_datetime': fullDateTime.toIso8601String(),
        'customer_name': customerName,
        'contact_number': contactNumber,
        'guests': guests,
        'special_request': specialRequest,
      }).eq('id', widget.bookingId);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Booking updated successfully!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Table Booking")),
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
                initialValue: customerName,
                decoration: InputDecoration(labelText: 'Customer Name'),
                validator: (value) => value!.isEmpty ? 'Enter name' : null,
                onSaved: (value) => customerName = value!,
              ),
              SizedBox(height: 10),
              TextFormField(
                initialValue: contactNumber,
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
                initialValue: specialRequest,
                decoration: InputDecoration(labelText: 'Special Requests'),
                maxLines: 3,
                onSaved: (value) => specialRequest = value ?? '',
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitBooking,
                child: Text("Update Booking"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
