import 'package:barbershop/features/home/presentation/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const RootsApp());
}

class RootsApp extends StatelessWidget {
  const RootsApp({super.key});

  @override
  Widget build(BuildContext context) {
    _init();

    // WidgetsBinding.instance.allowFirstFrame();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121214),
      ),
      home: const AppContainer(),
    );
  }
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  // WidgetsBinding.instance.addPostFrameCallback((_) {
  //   WidgetsBinding.instance.deferFirstFrame();
  // });
}

class AppContainer extends StatelessWidget {
  const AppContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 450),
          decoration: BoxDecoration(
            color: const Color(0xFF121214),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: WelcomeScreen(),
          ),
        ),
      ),
    );
  }
}
