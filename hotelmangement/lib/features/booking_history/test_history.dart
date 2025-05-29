import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BookingCalendar extends StatefulWidget {
  const BookingCalendar({super.key});

  @override
  State<BookingCalendar> createState() => _BookingCalendarState();
}

class _BookingCalendarState extends State<BookingCalendar> {
  final supabase = Supabase.instance.client;
  final String bookingId = '880e8400-e29b-41d4-a716-446655440001';

  String? error;
  DateTime? checkInDate;
  DateTime? checkOutDate;

  final scrollController = ScrollController();
  final today = DateTime.now();
  late final DateTime start;
  late final int initialMonthIndex;

  @override
  void initState() {
    super.initState();
    fetchRoomBookingDetails();

    start = DateTime(today.year, today.month - 12);
    initialMonthIndex = 12;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToTodayMonth();
    });
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

  void scrollToTodayMonth() {
    const double itemHeight = 320;
    scrollController.jumpTo(itemHeight * initialMonthIndex);
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return now.year == date.year &&
        now.month == date.month &&
        now.day == date.day;
  }

  bool _isCheckIn(DateTime date) {
    return checkInDate != null &&
        date.year == checkInDate!.year &&
        date.month == checkInDate!.month &&
        date.day == checkInDate!.day;
  }

  bool _isCheckOut(DateTime date) {
    return checkOutDate != null &&
        date.year == checkOutDate!.year &&
        date.month == checkOutDate!.month &&
        date.day == checkOutDate!.day;
  }

  Widget _legendBox(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(label),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final end = DateTime(today.year, today.month + 12);

    return Scaffold(
      appBar: AppBar(title: const Text("Booking Calendar")),
      body: ListView(
        controller: scrollController,
        children: [
          if (error != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(error!, style: const TextStyle(color: Colors.red)),
            ),
          if (checkInDate != null && checkOutDate != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Check-In: ${DateFormat.yMMMd().format(checkInDate!)}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Check-Out: ${DateFormat.yMMMd().format(checkOutDate!)}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                _legendBox(Colors.green, "Check-In"),
                const SizedBox(width: 10),
                _legendBox(Colors.orange, "Check-Out"),
              ],
            ),
          ),
          const SizedBox(height: 10),
          ...List.generate(
            end.difference(start).inDays ~/ 30 + 1,
            (index) {
              final date = DateTime(start.year, start.month + index);
              return buildMonth(date);
            },
          ),
        ],
      ),
    );
  }

  Widget buildMonth(DateTime date) {
    final daysInMonth = DateUtils.getDaysInMonth(date.year, date.month);
    final firstWeekday = DateTime(date.year, date.month, 1).weekday;

    List<Widget> dayWidgets = [];
    for (int i = 1; i < firstWeekday; i++) {
      dayWidgets.add(const SizedBox());
    }

    for (int i = 1; i <= daysInMonth; i++) {
      final currentDate = DateTime(date.year, date.month, i);

      Color? bg;
      if (_isToday(currentDate)) {
        bg = Colors.blue;
      } else if (_isCheckIn(currentDate)) {
        bg = Colors.green;
      } else if (_isCheckOut(currentDate)) {
        bg = Colors.orange;
      }

      dayWidgets.add(
        Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: bg,
            shape: BoxShape.circle,
          ),
          width: 40,
          height: 40,
          alignment: Alignment.center,
          child: Text(
            '$i',
            style: TextStyle(
              color: bg != null ? Colors.white : Colors.black,
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat.yMMMM().format(date),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          GridView.count(
            crossAxisCount: 7,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: dayWidgets,
          ),
        ],
      ),
    );
  }
}
