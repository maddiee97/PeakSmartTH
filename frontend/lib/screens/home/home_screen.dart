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
    return Scaffold(
      backgroundColor: const Color(0xFFFBF8F0),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Top green container with icons
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 34, 20, 24),
            decoration: BoxDecoration(
              color: const Color(0xFF356C33),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 45,
                        width: 45,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/settings');
                          },
                          child: Image.asset(
                            'assets/icons/settings.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/energy-tips');
                        },
                        child: SizedBox(
                          height: 45,
                          width: 45,
                          child: Image.asset(
                            'assets/icons/energytip.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Greeting with profile picture, centered horizontally
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 38,
                  backgroundImage: AssetImage('assets/images/avatar.png'),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isPeakHour ? "Good Day," : "Good Evening,",
                      style: const TextStyle(
                        fontSize: 32,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
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

          // Peak hour container
          Container(
            height: 273,
            width: 319,
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isPeakHour ? "YOU ARE IN" : "YOU ARE NOT IN",
                  style: const TextStyle(
                    fontSize: 32,
                    fontFamily: 'Poppins',
                    color: Colors.white,
                  ),
                ),
                Text(
                  "PEAK HOURS",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 48,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Countdown timer
          const Text(
            "02:00:00",
            style: TextStyle(
              fontSize: 32,
              fontFamily: 'Inter',
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          Text(
            isPeakHour
                ? "Countdown until Off-Peak Hours"
                : "Countdown until On-Peak Hours",
            style: const TextStyle(
              fontSize: 12,
              fontFamily: 'Inter',
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 16),

          // Advisory text
          const Text(
            "Turn off your air conditioner!",
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Inter',
              color: Color(0xFF858585),
            ),
          ),

          const SizedBox(height: 80),

          // Ad container
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
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
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
              onPressed: () {
                Navigator.pushNamed(context, '/calendar');
              },
              icon: Image.asset(
                'assets/icons/calendar.png',
                width: 28,
                height: 28,
                color: const Color(0xFFABABAB),
              ),
            ),
            const SizedBox(width: 16),
            IconButton(
              onPressed: () {
                // already on home
              },
              icon: Image.asset(
                'assets/icons/activehome.png',
                width: 40,
                height: 40,
              ),
            ),
            const SizedBox(width: 16),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
              icon: Image.asset(
                'assets/icons/profile.png',
                width: 24,
                height: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
