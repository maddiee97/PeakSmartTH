import 'package:flutter/material.dart';

class TopNavBar extends StatelessWidget {
  const TopNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
