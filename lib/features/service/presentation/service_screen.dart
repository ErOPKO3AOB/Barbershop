import 'package:barbershop/core/build_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int selectedServiceIndex = 0;

  // --- МОК-ДАННЫЕ ---

  // Таб 1: Услуги
  final List<Map<String, dynamic>> services = [
    {'name': 'Мужская стрижка', 'time': '1ч', 'price': '3000 р'},
    {'name': 'Стрижка машинкой', 'time': '1ч', 'price': '2100 р'},
    {'name': 'Стрижка ножницами', 'time': '1ч', 'price': '1800 р'},
    {'name': 'Fade', 'time': '1ч', 'price': '2400 р'},
    {'name': 'Детская стрижка', 'time': '1ч', 'price': '2200 р'},
    {'name': 'Стрижка бороды', 'time': '1ч', 'price': '2100 р'},
  ];

  // Таб 2: Мастера
  final List<Map<String, String>> masters = [
    {
      'name': 'Александр',
      'role': 'Топ-мастер',
      'img': 'assets/images/master1.webp',
    },
    {'name': 'Максим', 'role': 'Мастер', 'img': 'assets/images/master3.webp'},
    {
      'name': 'Игорь',
      'role': 'Топ-мастер',
      'img': 'assets/images/master4.webp',
    },
    {'name': 'Доминик', 'role': 'Эксперт', 'img': 'assets/images/master5.webp'},
    {'name': 'Сергей', 'role': 'Мастер', 'img': 'assets/images/master6.webp'},
    {'name': 'Дмитрий', 'role': 'Эксперт', 'img': 'assets/images/master2.webp'},
  ];

  // Таб 3: Премиум-пакеты/Акции
  final List<Map<String, String>> offers = [
    {
      'title': 'Royal Set',
      'desc': 'Стрижка + Борода + Уход',
      'price': '4500 р',
    },
    {'title': 'Express Look', 'desc': 'Стрижка за 30 минут', 'price': '1500 р'},
    {'title': 'Family Pack', 'детская': 'Отец + Сын', 'price': '5000 р'},
  ];

  @override
  void initState() {
    super.initState();
    // Длина TabController теперь соответствует 3 вкладкам
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121214),
      body: Stack(
        children: [
          // 1. ФОН (Растягивается на весь экран)
          Positioned.fill(
            child: Image.asset('assets/images/bg2.webp', fit: BoxFit.cover),
          ),

          // 2. КОНТЕНТ
          SafeArea(
            child: Column(
              children: [
                // Шапка (Лого + Адрес)
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Column(
                    children: [
                      const RootsLogo(),
                      const SizedBox(height: 8),
                      Text(
                        'Бауманская ул 15',
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                Text(
                  'ВЫБЕРИТЕ УСЛУГУ',
                  style: GoogleFonts.montserrat(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 15),

                // ТАБ-БАР
                TabBar(
                  controller: _tabController,
                  indicatorColor: const Color(0xFFE91E63),
                  indicatorSize: TabBarIndicatorSize.label,
                  dividerColor: Colors.transparent,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white38,
                  labelStyle: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                  tabs: const [
                    Tab(text: 'Запись'),
                    Tab(text: 'Наши Мастера'),
                    Tab(text: 'Топ Мастера'),
                  ],
                ),

                // ТАБ-ВЬЮ (Контент, который скроллится вбок)
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildServicesTab(), // Контент 1
                      _buildMastersGridTab(), // Контент 2 (Grid)
                      _buildOffersListTab(), // Контент 3 (Списки/Карточки)
                    ],
                  ),
                ),

                buildBottomNav(1),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- МЕТОДЫ РЕНДЕРИНГА ТАБОВ ---

  // ТАБ 1: Список услуг (как в твоем исходном коде)
  Widget _buildServicesTab() {
    return ListView.builder(
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
                      colors: [
                        Color(0xFFFFFFFF),
                        Color(0xFFFF4D94),
                        Color(0xFFE91E63),
                      ],
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
    );
  }

  // ТАБ 2: Сетка мастеров (Grid)
  Widget _buildMastersGridTab() {
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 колонки
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 0.75, // Пропорции карточки
      ),
      itemCount: masters.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1C1C1E),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    image: DecorationImage(
                      image: AssetImage(masters[index]['img']!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      masters[index]['name']!,
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      masters[index]['role']!,
                      style: GoogleFonts.montserrat(
                        color: Colors.white38,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ТАБ 3: Карточки акций (Специальные предложения)
  Widget _buildOffersListTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: offers.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFFE91E63).withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    offers[index]['title']!,
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    offers[index]['desc'] ?? offers[index]['детская']!,
                    style: GoogleFonts.montserrat(
                      color: Colors.white38,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              Text(
                offers[index]['price']!,
                style: GoogleFonts.montserrat(
                  color: const Color(0xFFE91E63),
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class RootsLogo extends StatelessWidget {
  const RootsLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset('assets/images/logo.svg', width: 120, height: 40);
  }
}
