
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildBottomNav(int currentIndex) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            navItem(Icons.home_filled, 'ГЛАВНАЯ', currentIndex == 0),
            navItem(Icons.content_cut, 'УСЛУГИ', currentIndex == 1),
            navItem(Icons.percent, 'АКЦИИ', false),
            navItem(Icons.person, 'ПРОФИЛЬ', false),
          ],
        ),
      ),
    ],
  );
}

Widget navItem(IconData icon, String label, bool isActive) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, color: isActive ? Colors.white : Colors.white38, size: 24),
      const SizedBox(height: 4),
      Text(
        label,
        style: GoogleFonts.montserrat(
          color: isActive ? Colors.white : Colors.white38,
          fontSize: 9,
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}
