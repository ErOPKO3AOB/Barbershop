import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddressDropdown extends StatefulWidget {
  const AddressDropdown({super.key});

  @override
  State<AddressDropdown> createState() => AddressDropdownState();
}

class AddressDropdownState extends State<AddressDropdown> {
  String _selectedAddress = 'Бауманская ул 15';

  final List<String> _addresses = [
    'Бауманская ул 15',
    'Тверская ул 7',
    'Арбат ул 10',
    'Невский пр-т 12',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: const BoxDecoration(
        color: Colors.transparent, // Легкий полупрозрачный фон
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedAddress,
          dropdownColor: Colors.black.withAlpha(150), // Темный фон для списка
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
          isDense: true, // Делает виджет компактным
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                _selectedAddress = newValue;
              });
            }
          },
          items: _addresses.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
        ),
      ),
    );
  }
}
