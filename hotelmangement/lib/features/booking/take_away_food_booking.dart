import 'package:flutter/material.dart';

void main() {
  runApp(TakeAwayBookingApp());
}

class TakeAwayBookingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Take Away Food Booking',
      home: TakeAwayBookingPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TakeAwayBookingPage extends StatefulWidget {
  @override
  _TakeAwayBookingPageState createState() => _TakeAwayBookingPageState();
}

class _TakeAwayBookingPageState extends State<TakeAwayBookingPage> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  int quantity = 1;
  String? selectedFoodId;

  final PageController _pageController = PageController(viewportFraction: 0.8);

  // Food list
  final List<Map<String, String>> foodList = [
    {'id': '1', 'name': 'Pizza', 'image': 'assets/booking/pizza.jpg'},
    {'id': '2', 'name': 'Burger', 'image': 'assets/booking/burger.jpg'},
    {'id': '3', 'name': 'Sushi', 'image': 'assets/booking/sushi.jpg'},
  ];

  void _bookFood() {
    if (selectedFoodId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a food item')),
      );
      return;
    }

    final selectedFood =
        foodList.firstWhere((food) => food['id'] == selectedFoodId);

    print('Booking Created:');
    print('Date: $selectedDate');
    print('Time: ${selectedTime.format(context)}');
    print('Quantity: $quantity');
    print('Food: ${selectedFood['name']}');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Booked ${selectedFood['name']} x$quantity for ${selectedDate.toLocal().toString().split(' ')[0]} at ${selectedTime.format(context)}'),
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: PageView.builder(
                controller: _pageController,
                itemCount: foodList.length,
                itemBuilder: (context, index) {
                  final food = foodList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            food['image']!,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            color: Colors.black.withOpacity(0.4),
                            alignment: Alignment.bottomCenter,
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              food['name']!,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedFoodId,
              hint: Text("Select Food"),
              items: foodList.map((food) {
                return DropdownMenuItem(
                  value: food['id'],
                  child: Text(food['name']!),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedFoodId = value;
                });
              },
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
              onChanged: (val) {
                quantity = int.tryParse(val) ?? 1;
              },
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _selectDate,
                    child: Text("Select Date"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _selectTime,
                    child: Text("Select Time"),
                  ),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _bookFood,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text('Book Now'),
            ),
          ],
        ),
      ),
    );
  }
}
