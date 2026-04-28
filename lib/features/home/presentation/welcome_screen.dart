// welcome_screen.dart
import 'package:barbershop/consts/server_path.dart';
import 'package:barbershop/core/build_bottom_nav.dart';
import 'package:barbershop/core/custom_animations.dart';
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
              _TitleSection(),

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
          dropdownColor: Colors.black.withAlpha(100), // Темный фон для списка
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

/// Заголовок, на 100% стабильный — никаких перестроек
class _TitleSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min, // теперь только по содержимому
        children: [
          const _PulsingWord('ОБНОВИ', delay: Duration.zero),
          const _PulsingWord('СВОЙ СТИЛЬ', delay: Duration(milliseconds: 200)),
        ],
      ),
    );
  }
}

/// Каждое слово – это просто текстовый виджет, обёрнутый в Animate со scale
class _PulsingWord extends StatefulWidget {
  final String text;
  final Duration delay;

  const _PulsingWord(this.text, {required this.delay});

  @override
  State<_PulsingWord> createState() => _PulsingWordState();
}

class _PulsingWordState extends State<_PulsingWord>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // Запускаем вход через flutter_animate, а потом включаем пульсацию
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(600.ms + widget.delay, () {
        if (mounted) {
          _pulseController.repeat(reverse: true);
        }
      });
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Animate(
      // Чистый flutter_animate для входной анимации
      effects: [
        ScaleEffect(
          begin:
              Offset.zero, // на самом деле 0.7, но ScaleEffect принимает Offset
          end: const Offset(1.0, 1.0),
          duration: 600.ms,
          curve: Curves.easeOut,
        ),
      ],
      child: SizedBox(
        height: 65,
        child: Center(
          child: AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              final scale = 1.0 + (_pulseController.value * 0.06);
              return Transform.scale(
                scale: scale,
                alignment: Alignment.center,
                child: child,
              );
            },
            child: Text(
              widget.text,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 45,
                fontWeight: FontWeight.w900,
                height: 1.1,
              ),
            ),
          ),
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
