import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



class BookingCalendar extends StatefulWidget {
  const BookingCalendar({super.key});

  @override
  State<BookingCalendar> createState() => _BookingCalendarState();
}

class _BookingCalendarState extends State<BookingCalendar> {
  final List<DateTime> futureBookings = [
    DateTime.now().add(const Duration(days: 2)),
    DateTime.now().add(const Duration(days: 5)),
  ];

  final List<DateTime> pastBookings = [
    DateTime.now().subtract(const Duration(days: 2)),
    DateTime.now().subtract(const Duration(days: 5)),
  ];

  final scrollController = ScrollController();
  final today = DateTime.now();
  late final DateTime start;
  late final int initialMonthIndex;

  @override
  void initState() {
    super.initState();
    start = DateTime(today.year, today.month - 12);
    initialMonthIndex = 12;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToTodayMonth();
    });
  }

  void scrollToTodayMonth() {
    const double itemHeight = 320;
    scrollController.jumpTo(itemHeight * initialMonthIndex);
  }

  @override
  Widget build(BuildContext context) {
    final end = DateTime(today.year, today.month + 12);

    return Scaffold(
      appBar: AppBar(title: const Text("Booking Calendar")),
      body: ListView.builder(
        controller: scrollController,
        itemCount: end.difference(start).inDays ~/ 30 + 1,
        itemBuilder: (context, index) {
          final date = DateTime(start.year, start.month + index);
          return buildMonth(date);
        },
      ),
    );
  }

  Widget buildMonth(DateTime date) {
    final daysInMonth = DateUtils.getDaysInMonth(date.year, date.month);
    final firstWeekday = DateTime(date.year, date.month, 1).weekday;
    final isPastMonth = date.year < today.year ||
        (date.year == today.year && date.month < today.month);

    List<Widget> dayWidgets = [];
    for (int i = 1; i < firstWeekday; i++) {
      dayWidgets.add(const SizedBox());
    }

    for (int i = 1; i <= daysInMonth; i++) {
      final currentDate = DateTime(date.year, date.month, i);
      final isPastDate = currentDate.isBefore(DateTime(
        today.year,
        today.month,
        today.day,
      ));

      Color? bg;
      if (_isToday(currentDate)) {
        bg = Colors.blue;
      } else if (_containsDate(futureBookings, currentDate)) {
        bg = Colors.black;
      } else if (_containsDate(pastBookings, currentDate)) {
        bg = Colors.red;
      }

      bool isInteractive = !isPastMonth && !isPastDate;
      double opacity = (isPastMonth || isPastDate) ? 0.6 : 1.0;

      dayWidgets.add(
        Opacity(
          opacity: opacity,
          child: GestureDetector(
            onTap: isInteractive && bg != null
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BookingDetailPage(date: currentDate),
                      ),
                    );
                  }
                : null,
            child: Container(
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

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return now.year == date.year &&
        now.month == date.month &&
        now.day == date.day;
  }

  bool _containsDate(List<DateTime> list, DateTime date) {
    return list.any((d) =>
        d.year == date.year && d.month == date.month && d.day == date.day);
  }
}

class BookingDetailPage extends StatelessWidget {
  final DateTime date;
  const BookingDetailPage({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(DateFormat.yMMMMd().format(date))),
      body: Center(
        child: Text(
          "Details for ${DateFormat.yMMMMEEEEd().format(date)}",
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
