import 'package:flutter/material.dart';
import 'package:peaksmart_app/screens/home/main_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final username = 'YourUsername'; // Replace with actual user data
    final email = 'your@email.com';
    final provider = 'PEA';

    return Scaffold(
      backgroundColor: const Color(0xFFFBF8F0),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Green top bar with back button
          Container(
            height: 76 + MediaQuery.of(context).padding.top,
            width: double.infinity,
            color: const Color(0xFF366D34),
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 12,
              left: 20,
            ),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Settings',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600, // SemiBold
                fontSize: 24,
                color: Colors.black,
              ),
            ),
          ),

          const SizedBox(height: 24),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Main',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500, // Medium
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),

          const SizedBox(height: 12),

          // ✅ Navigate to ProfileScreen via MainScreen with selected index
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MainScreen(
                    username: username,
                    email: email,
                    provider: provider,
                    initialIndex: 2, // Profile tab
                  ),
                ),
              );
            },
            child: _settingTile('Edit profile'),
          ),

          _buildSettingItem(context, 'Notifications', '/notifications'),
          _buildSettingItem(context, 'Change Password', '/change-password'),

          const SizedBox(height: 24),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'More',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500, // Medium
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),

          const SizedBox(height: 12),

          _buildSettingItem(context, 'About us', '/about-us'),
          _buildSettingItem(context, 'Terms and conditions', '/terms'),

          const Spacer(),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 24),
            child: OutlinedButton(
              onPressed: () {
                // TODO: Add logout logic
              },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                side: const BorderSide(color: Color(0xFF366D34)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Logout",
                style: TextStyle(
                  color: Color(0xFF366D34),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _settingTile(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              fontSize: 15,
              color: Colors.black,
            ),
          ),
          Image.asset(
            'assets/icons/navigationarrow.png',
            width: 24,
            height: 24,
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(BuildContext context, String title, String route) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      child: _settingTile(title),
    );
  }
}
