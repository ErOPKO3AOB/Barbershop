import 'package:barbershop/features/service/presentation/service_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderButton extends StatelessWidget {
  const OrderButton({super.key});

  @override
  Widget build(BuildContext context) {
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
}
