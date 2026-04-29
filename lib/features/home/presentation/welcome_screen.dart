// welcome_screen.dart
import 'package:barbershop/consts/server_path.dart';
import 'package:barbershop/core/build_bottom_nav.dart';
import 'package:barbershop/core/custom_animations.dart';
import 'package:barbershop/features/home/presentation/title_section.dart';
import 'package:barbershop/features/service/presentation/service_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // ВАЖНО: позволяет контенту быть под плавающим баром
      bottomNavigationBar: SafeArea(child: buildBottomNav(context, 0)),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('${serverPath}bg1.webp'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const Spacer(flex: 1),

              const RootsLogo().animate().richIntro(
                shimmerColor: Colors.redAccent,
              ),

              const SizedBox(height: 12),

              // Органично вписанный выпадающий список адресов
              const _AddressDropdown().animate().defaultIntro(),

              const Spacer(flex: 2),

              // Заголовок – теперь без жёсткой высоты
              TitleSection(),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 20,
                ),
                child: Text(
                  'выбери пространство, где каждая стрижка создается как персональный шедевр',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    color: Colors.white, // добавил белый цвет для читаемости
                  ),
                ),
              ).animate().fadeIn(delay: 800.ms),

              const Spacer(flex: 2),

              Padding(
                padding: const EdgeInsets.only(
                  bottom: 110,
                ), // Подняли кнопку выше, чтобы не перекрывалась баром
                child: _buildOrderButton(context),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

/// Виджет выпадающего списка с выбором барбершопа (улицы)
class _AddressDropdown extends StatefulWidget {
  const _AddressDropdown();

  @override
  State<_AddressDropdown> createState() => _AddressDropdownState();
}

class _AddressDropdownState extends State<_AddressDropdown> {
  // Текущий выбранный адрес
  String _selectedAddress = 'Бауманская ул 15';

  // Список доступных адресов (можно расширять)
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

// -------------------------------------------------------------
// ИЗМЕНЕНИЯ ЗДЕСЬ: Анимация перехода для кнопки "ЗАПИСАТЬСЯ"
// -------------------------------------------------------------
Widget _buildOrderButton(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(140, 255, 255, 255),
            blurRadius: 25,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          // Используем ту же анимацию Slide + Fade, что и в Bottom Nav Bar
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const ServicesScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    final curve = CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutCubic,
                    );

                    return FadeTransition(
                      opacity: curve,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(
                            0.0,
                            0.05,
                          ), // Мягко выплывает снизу
                          end: Offset.zero,
                        ).animate(curve),
                        child: child,
                      ),
                    );
                  },
              transitionDuration: const Duration(milliseconds: 500),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          minimumSize: const Size(double.infinity, 65),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          'ЗАПИСАТЬСЯ',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w800,
            fontSize: 21,
          ),
        ),
      ),
    ),
  );
}
