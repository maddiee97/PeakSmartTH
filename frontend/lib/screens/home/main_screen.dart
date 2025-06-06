import 'package:flutter/material.dart';
import 'package:peaksmart_app/screens/home/home_screen.dart';
import 'package:peaksmart_app/screens/schedule/schedule_screen.dart';
import 'package:peaksmart_app/screens/settings/profile_screen.dart';

class MainScreen extends StatefulWidget {
  final String username;
  final String email;
  final String provider;
  final int initialIndex;

  const MainScreen({
    Key? key,
    required this.username,
    required this.email,
    required this.provider,
    this.initialIndex = 1,
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      const ScheduleScreen(),
      HomeScreen(
        username: widget.username,
        email: widget.email,
        provider: widget.provider,
      ),
      ProfileScreen(
        username: widget.username,
        email: widget.email,
        provider: widget.provider,
      ),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () => setState(() => _selectedIndex = 0),
              icon: Image.asset(
                _selectedIndex == 0
                    ? 'assets/icons/activecalendar.png'
                    : 'assets/icons/calendar.png',
                width: 28,
                height: 28,
              ),
            ),
            IconButton(
              onPressed: () => setState(() => _selectedIndex = 1),
              icon: Image.asset(
                _selectedIndex == 1
                    ? 'assets/icons/activehome.png'
                    : 'assets/icons/Home.png',
                width: 40,
                height: 40,
              ),
            ),
            IconButton(
              onPressed: () => setState(() => _selectedIndex = 2),
              icon: Image.asset(
                _selectedIndex == 2
                    ? 'assets/icons/activeprofile.png'
                    : 'assets/icons/profile.png',
                width: 28,
                height: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
