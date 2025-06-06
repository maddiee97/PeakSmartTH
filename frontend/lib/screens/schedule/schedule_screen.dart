import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'calendar_widget.dart';
import 'package:peaksmart_app/screens/home/top_navbar.dart'; // Adjust import path if needed

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final List<DateTime> dates = List.generate(
    7,
    (index) => DateTime(DateTime.now().year, 1, 18 + index),
  );

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = dates[selectedIndex];

    List<String> times =
        List.generate(24, (i) => '${i.toString().padLeft(2, '0')}:00');

    bool isPeakHour(String time) {
      if (selectedDate.day == 21) return time != '00:00';
      return false;
    }

    String holidayText() {
      if (selectedDate.day == 21) return 'No Holiday Today';
      if (selectedDate.day == 24) return 'Songkran Festival';
      return 'No Holiday';
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: const Color(0xFFFBF8F0),
        body: Column(
          children: [
            const TopNavBar(), // ✅ replaced green container
            const SizedBox(height: 30),
            Center(
              child: Container(
                width: 364,
                height: 612,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F2E5),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Schedule',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 36,
                          color: Color(0xFF356C33),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.only(left: 4),
                      child: Text(
                        'January',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    CalendarWidget(
                      dates: dates,
                      selectedIndex: selectedIndex,
                      onDateSelected: (index) {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.only(left: 4),
                      child: Text(
                        'Schedule Today',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: ListView.separated(
                        itemCount: times.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 16),
                        itemBuilder: (_, i) {
                          final time = times[i];
                          final peak = isPeakHour(time);
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 60,
                                  child: Text(
                                    time,
                                    style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Color(0xFF94A3B8),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 32),
                                Text(
                                  peak ? 'Peak Hour' : 'Off-Peak Hour',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: peak
                                        ? const Color(0xFFFF0000)
                                        : const Color(0xFF356C33),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Text(
                        'Holiday: ${holidayText()}',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
