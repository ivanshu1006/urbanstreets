import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class StoriesArchiveCalendar extends StatefulWidget {
  const StoriesArchiveCalendar({Key? key}) : super(key: key);

  @override
  _StoriesArchiveCalendarState createState() => _StoriesArchiveCalendarState();
}

class _StoriesArchiveCalendarState extends State<StoriesArchiveCalendar> {
  DateTime _focusedDay = DateTime(2024, 12, 15);
  DateTime? _selectedDay;

  // Set of highlighted dates
  final Set<DateTime> _highlightedDates = {
    // November 2024 dates
    DateTime(2024, 11, 11),
    DateTime(2024, 11, 18),
    DateTime(2024, 11, 20),
    DateTime(2024, 11, 27),
    
    // December 2024 dates
    DateTime(2024, 12, 5),
    DateTime(2024, 12, 15),
    
    // January 2025 dates
    DateTime(2025, 1, 1),
    DateTime(2025, 1, 13)
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TableCalendar(
        firstDay: DateTime.utc(2024, 1, 1),
        lastDay: DateTime.utc(2025, 12, 31),
        focusedDay: _focusedDay,
        calendarFormat: CalendarFormat.month,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_selectedDay, selectedDay)) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          }
        },
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, day, focusedDay) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Text(
                    '${day.day}',
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                // Add blue dot for highlighted dates
                if (_highlightedDates.any((highlightedDate) => 
                    isSameDay(highlightedDate, day)))
                  Positioned(
                    bottom: 4,
                    child: Container(
                      height: 6,
                      width: 6,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  // Helper method to check if two dates are the same day
  bool isSameDay(DateTime? a, DateTime? b) {
    if (a == null || b == null) {
      return false;
    }
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}