import 'package:barbershop/consts/server_path.dart';
import 'package:barbershop/core/build_bottom_nav.dart';
import 'package:barbershop/core/custom_animations.dart';
import 'package:barbershop/features/home/presentation/address_dropdown.dart';
import 'package:barbershop/features/home/presentation/order_button.dart';
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
      extendBody: true,
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

              const AddressDropdown().animate().defaultIntro(),

              const Spacer(flex: 2),

              const TitleSection(),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 20,
                ),
                child: Text(
                  'выбери пространство, где каждая стрижка создается как персональный шедевр',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(color: Colors.white),
                ),
              ).animate().fadeIn(delay: 800.ms),

              const Spacer(flex: 2),

              Padding(
                padding: const EdgeInsets.only(bottom: 110),
                child: OrderButton(),
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
