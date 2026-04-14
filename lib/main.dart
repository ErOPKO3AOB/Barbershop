import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const RootsApp());
}

class RootsApp extends StatelessWidget {
  const RootsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121214), 
      ),
      home: const AppContainer(),
    );
  }
}

// Обертка, имитирующая скругленное окно
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
              )
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: const WelcomeScreen(),
          ),
        ),
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg1.png',
              fit: BoxFit.cover,
              color: Colors.black.withValues(alpha: 0.4), // ИСПРАВЛЕНО
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
                    Colors.black.withValues(alpha: 0.7), // ИСПРАВЛЕНО
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.9), // ИСПРАВЛЕНО
                  ],
                  stops: const [0.0, 0.2, 0.7, 1.0],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                _buildHeader(context),
                const Spacer(flex: 1),
                const RootsLogo(),
                const SizedBox(height: 8),
                Text(
                  'Бауманская ул 15',
                  style: GoogleFonts.montserrat(color: Colors.white, fontSize: 17),
                ),
                const Spacer(flex: 5),
                Text(
                  'ОБНОВИ\nСВОЙ СТИЛЬ',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: 45,
                    fontWeight: FontWeight.w900,
                    height: 1.3,
                    letterSpacing: 1.6,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: Text(
                    'выбери пространство, где каждая стрижка создаётся как персональный шедевр',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color: Colors.white.withValues(alpha: 0.8),
                      height: 1.3,
                    ),
                  ),
                ),
                SizedBox(height: 150),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ServicesScreen()),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      minimumSize: const Size(double.infinity, 55),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      elevation: 0,
                    ),
                    child: Text(
                      'ЗАПИСАТЬСЯ',
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w800, fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Spacer(),
                _buildBottomNav(0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int selectedServiceIndex = 0;

  final List<Map<String, dynamic>> services = [
    {'name': 'Мужская стрижка', 'time': '1ч', 'price': '3000 р'},
    {'name': 'Стрижка машинкой', 'time': '1ч', 'price': '2100 р'},
    {'name': 'Стрижка ножницами', 'time': '1ч', 'price': '1800 р'},
    {'name': 'Fade', 'time': '1ч', 'price': '2400 р'},
    {'name': 'Детская стрижка', 'time': '1ч', 'price': '2200 р'},
    {'name': 'Стрижка бороды', 'time': '1ч', 'price': '2100 р'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121214),
      body: SafeArea(
        child: Stack(
          children: [ 
            Center(
              child: Image.asset(
                'assets/images/bg2.png',
                // fit: BoxFit.cover,
                // color: Colors.black.withValues(alpha: 0.4), 
                // colorBlendMode: BlendMode.darken,
              ),
            ),
            Column(
            children: [
              _buildHeader(context, showBack: true),
              const RootsLogo(),
              const SizedBox(height: 4),
              Text('Бауманская ул 15', style: GoogleFonts.montserrat(fontSize: 12, color: Colors.white)),
              const SizedBox(height: 20),
              Text(
                'ВЫБЕРИТЕ УСЛУГУ',
                style: GoogleFonts.montserrat(fontSize: 22, fontWeight: FontWeight.w900, letterSpacing: 0.5),
              ),
              const SizedBox(height: 15),
              TabBar(
                controller: _tabController,
                indicatorColor: const Color(0xFFE91E63),
                indicatorSize: TabBarIndicatorSize.label,
                dividerColor: Colors.transparent,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white38,
                labelStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 13),
                tabs: const [
                  Tab(text: 'Амбассадор'),
                  Tab(text: 'Мастер-эксперт'),
                  Tab(text: 'Топ-мастер'),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: services.length,
                  itemBuilder: (context, index) {
                    bool isSelected = selectedServiceIndex == index;
                    return GestureDetector(
                      onTap: () => setState(() => selectedServiceIndex = index),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        height: 48,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: isSelected ? null : const Color(0xFF1C1C1E),
                          gradient: isSelected
                              ? const LinearGradient(
                                  colors: [Color(0xFFFFFFFF), Color(0xFFFF4D94), Color(0xFFE91E63)],
                                  stops: [0.0, 0.65, 1.0],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                )
                              : null,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  style: GoogleFonts.montserrat(
                                    color: isSelected ? Colors.black : Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                  children: [
                                    TextSpan(text: services[index]['name']),
                                    TextSpan(
                                      text: '  ${services[index]['time']}',
                                      style: TextStyle(
                                        color: isSelected ? Colors.black54 : Colors.white38,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Text(
                              services[index]['price'],
                              style: GoogleFonts.montserrat(
                                color: isSelected ? Colors.black : Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isSelected ? Colors.white : Colors.transparent,
                                border: Border.all(
                                  color: isSelected ? Colors.white : Colors.white24,
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              _buildBottomNav(1),
            ],
          ),
          ],
        ),
      ),
    );
  }
}

// --- ВСПОМОГАТЕЛЬНЫЕ ВИДЖЕТЫ ---

class RootsLogo extends StatelessWidget {
  const RootsLogo({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/images/logo.svg',
      width: 120,
      height: 40,
    );
  }
}

Widget _buildHeader(BuildContext context, {bool showBack = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        showBack
            ? GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back, size: 24),
              )
            : const SizedBox(width: 24),
        Text(
          'Roots Men’s Cut',
          style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const Row(
          children: [
            Icon(Icons.more_horiz, size: 20),
            SizedBox(width: 12),
            Icon(Icons.close, size: 20),
          ],
        ),
      ],
    ),
  );
}

Widget _buildBottomNav(int currentIndex) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.05))), // ИСПРАВЛЕНО
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(Icons.home_filled, 'ГЛАВНАЯ', currentIndex == 0),
            _navItem(Icons.content_cut, 'УСЛУГИ', currentIndex == 1),
            _navItem(Icons.percent, 'АКЦИИ', false),
            _navItem(Icons.person, 'ПРОФИЛЬ', false),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          '@rootsmenscut_bot',
          style: GoogleFonts.montserrat(fontSize: 10, color: Colors.white24),
        ),
      ),
    ],
  );
}

Widget _navItem(IconData icon, String label, bool isActive) {
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