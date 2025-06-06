import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final String username;
  final String email;
  final String provider;
  final bool isPeakHour;

  const HomeScreen({
    super.key,
    required this.username,
    required this.email,
    required this.provider,
    this.isPeakHour = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFBF8F0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Top green header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 34, 20, 24),
              decoration: const BoxDecoration(
                color: Color(0xFF356C33),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/settings'),
                    child: Image.asset(
                      'assets/icons/settingsicon.png',
                      height: 47,
                      width: 47,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/energy-tips'),
                    child: Image.asset(
                      'assets/icons/energytipseditor.png',
                      height: 43,
                      width: 43,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Greeting & profile
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 38,
                    backgroundImage: AssetImage('assets/images/avatar.png'),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isPeakHour ? "Good Day," : "Good Evening,",
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                          color: Color(0xFF356C33),
                        ),
                      ),
                      Text(
                        username,
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Inter',
                          color: Color(0xFF858585),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Peak Hour Card
            Container(
              height: 273,
              width: 319,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isPeakHour
                    ? const Color(0xFFFF5B52)
                    : const Color(0xFF4CAF50),
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      "YOU ARE IN",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 32, color: Colors.white),
                    ),
                    Text(
                      "PEAK HOURS",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Text("02:00:00",
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter')),
            Text(
              isPeakHour
                  ? "Countdown until Off-Peak Hours"
                  : "Countdown until On-Peak Hours",
              style: const TextStyle(fontSize: 12, color: Colors.black),
            ),

            const SizedBox(height: 16),
            const Text("Turn off your air conditioner!",
                style: TextStyle(fontSize: 16, color: Color(0xFF858585))),

            const SizedBox(height: 80),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 50),
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: const Text(
                "AD",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
