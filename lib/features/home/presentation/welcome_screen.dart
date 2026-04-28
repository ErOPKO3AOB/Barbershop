import 'package:barbershop/core/build_bottom_nav.dart';
import 'package:barbershop/features/service/presentation/service_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg1.webp',
              fit: BoxFit.cover,
              // color: Colors.black.withValues(alpha: 0.3),
              colorBlendMode: BlendMode.darken,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.5),
                    // Colors.transparent,
                    Colors.transparent,
                    // Colors.white.withValues(alpha: 0.0),
                  ],
                  stops: const [0.0, 4.0],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const Spacer(flex: 1),
                const RootsLogo(),
                const SizedBox(height: 8),
                Text(
                  'Бауманская ул 15',
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
                const Spacer(flex: 5),
                Text(
                  'ОБНОВИ\nСВОЙ СТИЛЬ',
                  textAlign: TextAlign.center,

                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 45,
                    fontWeight: FontWeight.w900,
                    height: 1.3,
                    letterSpacing: 1.6,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 20,
                  ),
                  child: Text(
                    'выбери пространство, где каждая стрижка создаётся как персональный шедевр',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: Colors.white.withValues(alpha: 0.8),
                      height: 1.3,
                    ),
                  ),
                ),
                SizedBox(height: 150),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                    // 1. Создаем эффект свечения через BoxDecoration
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withValues(
                            alpha: 0.4,
                          ), // Цвет свечения (белый с прозрачностью)
                          blurRadius:
                              25, // Насколько мягким и широким будет свечение
                          spreadRadius:
                              2, // Насколько далеко оно расходится от краев
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ServicesScreen(),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        minimumSize: const Size(double.infinity, 65),
                        elevation: 0,
                        shadowColor: Colors.transparent,

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
                ),
                const SizedBox(height: 10),
                const Spacer(),
                buildBottomNav(0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
