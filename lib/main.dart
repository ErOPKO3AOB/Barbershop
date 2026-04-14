import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        scaffoldBackgroundColor: const Color(0xFF0F0F0F), // Глубокий черный
      ),
      home: const WelcomeScreen(),
    );
  }
}

// --- ЭКРАН 1: ПРИВЕТСТВИЕ ---
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover,
                // Затемнение для читаемости текста
                colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                _buildHeader(context),
                const Spacer(),
                Text(
                  'ОБНОВИ\nСВОЙ СТИЛЬ',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                    height: 1.1,
                    letterSpacing: -1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 24),
                  child: Text(
                    'выбери пространство, где каждая стрижка создаётся как персональный шедевр',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 15,
                      color: Colors.white.withOpacity(0.8),
                      height: 1.4,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ServicesScreen())),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      minimumSize: const Size(double.infinity, 65),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                      elevation: 0,
                    ),
                    child: Text('ЗАПИСАТЬСЯ', 
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w800, fontSize: 18)
                    ),
                  ),
                ),
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

// --- ЭКРАН 2: ВЫБОР УСЛУГИ ---
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
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, showBack: true),
            Text('ROOTS', style: GoogleFonts.montserrat(fontSize: 28, fontWeight: FontWeight.w900, letterSpacing: 2)),
            Text('men\'s cut', style: GoogleFonts.montserrat(fontSize: 12, color: Colors.white54)),
            const SizedBox(height: 4),
            Text('Бауманская ул 15', style: GoogleFonts.montserrat(fontSize: 13, color: Colors.white38)),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Text('ВЫБЕРИТЕ УСЛУГУ', 
                style: GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.w800)
              ),
            ),
            TabBar(
              controller: _tabController,
              indicatorColor: const Color(0xFFE91E63),
              indicatorWeight: 3,
              labelStyle: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 13),
              unselectedLabelColor: Colors.white38,
              tabs: const [
                Tab(text: 'Амбассадор'),
                Tab(text: 'Мастер-эксперт'),
                Tab(text: 'Топ-мастер'),
              ],
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                itemCount: services.length,
                itemBuilder: (context, index) {
                  bool isSelected = selectedServiceIndex == index;
                  return GestureDetector(
                    onTap: () => setState(() => selectedServiceIndex = index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40), // Тот самый скругленный "вырез"
                        gradient: isSelected 
                          ? const LinearGradient(
                              colors: [Color(0xFFE91E63), Color(0xFF880E4F)], // Градиент из Figma
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ) 
                          : null,
                        color: isSelected ? null : const Color(0xFF1E1E1E),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(services[index]['name'], 
                                  style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w700)),
                                const SizedBox(height: 4),
                                Text(services[index]['time'], 
                                  style: GoogleFonts.montserrat(color: Colors.white60, fontSize: 12)),
                              ],
                            ),
                          ),
                          Text(services[index]['price'], 
                            style: GoogleFonts.montserrat(fontWeight: FontWeight.w800, fontSize: 16)),
                          const SizedBox(width: 15),
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                              color: isSelected ? Colors.white : Colors.transparent,
                            ),
                            child: isSelected 
                              ? const Icon(Icons.check, size: 16, color: Color(0xFFE91E63)) 
                              : null,
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
      ),
    );
  }
}

// --- ВСПОМОГАТЕЛЬНЫЕ ВИДЖЕТЫ ---

Widget _buildHeader(BuildContext context, {bool showBack = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        showBack 
          ? IconButton(icon: const Icon(Icons.arrow_back_ios_new, size: 20), onPressed: () => Navigator.pop(context))
          : const SizedBox(width: 48),
        Text('Roots Men’s Cut', style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w500)),
        Row(
          children: [
            IconButton(icon: const Icon(Icons.more_horiz), onPressed: () {}),
            IconButton(icon: const Icon(Icons.close), onPressed: () {}),
          ],
        ),
      ],
    ),
  );
}

Widget _buildBottomNav(int currentIndex) {
  return Container(
    padding: const EdgeInsets.only(top: 15, bottom: 25),
    decoration: BoxDecoration(
      color: const Color(0xFF0F0F0F),
      border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05))),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _navItem(Icons.home_filled, 'ГЛАВНАЯ', currentIndex == 0),
        _navItem(Icons.content_cut, 'УСЛУГИ', currentIndex == 1),
        _navItem(Icons.local_offer_outlined, 'АКЦИИ', false),
        _navItem(Icons.person_outline, 'ПРОФИЛЬ', false),
      ],
    ),
  );
}

Widget _navItem(IconData icon, String label, bool isActive) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, color: isActive ? const Color(0xFFE91E63) : Colors.white38, size: 26),
      const SizedBox(height: 6),
      Text(label, style: GoogleFonts.montserrat(
        color: isActive ? Colors.white : Colors.white38, 
        fontSize: 10, 
        fontWeight: FontWeight.w600
      )),
    ],
  );
}