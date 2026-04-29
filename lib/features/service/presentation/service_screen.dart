// service_screen.dart
import 'package:barbershop/consts/server_path.dart';
import 'package:barbershop/core/build_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart'; // ВАЖНО: Добавили для каскадных анимаций
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
      'img': '${serverPath}master1.webp',
    },
    {'name': 'Максим', 'role': 'Мастер', 'img': '${serverPath}master3.webp'},
    {'name': 'Игорь', 'role': 'Топ-мастер', 'img': '${serverPath}master4.webp'},
    {'name': 'Доминик', 'role': 'Эксперт', 'img': '${serverPath}master5.webp'},
    {'name': 'Сергей', 'role': 'Мастер', 'img': '${serverPath}master6.webp'},
    {'name': 'Дмитрий', 'role': 'Эксперт', 'img': '${serverPath}master2.webp'},
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
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121214),
      extendBody: true,
      bottomNavigationBar: SafeArea(child: buildBottomNav(context, 1)),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network('${serverPath}bg2.webp', fit: BoxFit.cover),
          ),

          SafeArea(
            bottom: false,
            child: Column(
              children: [
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

                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildServicesTab(),
                      _buildMastersGridTab(),
                      _buildOffersListTab(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- МЕТОДЫ РЕНДЕРИНГА ТАБОВ ---

  // ТАБ 1: Список услуг (Теперь с плавной анимацией выбора!)
  Widget _buildServicesTab() {
    return ListView.builder(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 100),
      itemCount: services.length,
      itemBuilder: (context, index) {
        return ServiceItem(
          key: ValueKey(index), // стабильный ключ, чтобы не пересоздавать
          data: services[index],
          isSelected: selectedServiceIndex == index,
          animationDelay: Duration(milliseconds: index * 40),
          onTap: () {
            setState(() {
              selectedServiceIndex = index;
            });
          },
        );
      },
    );
  }

  // ТАБ 2: Сетка мастеров
  Widget _buildMastersGridTab() {
    return GridView.builder(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 100),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 0.75,
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
                          image: NetworkImage(masters[index]['img']!),
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
            )
            .animate() // Каскадное появление карточек мастеров
            .fadeIn(delay: (index * 50).ms)
            .scale(begin: const Offset(0.9, 0.9), curve: Curves.easeOutCubic);
      },
    );
  }

  // ТАБ 3: Карточки акций
  Widget _buildOffersListTab() {
    return ListView.builder(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 100),
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
            )
            .animate() // Каскадное появление акций
            .fadeIn(delay: (index * 80).ms)
            .slideY(begin: 0.1, end: 0, curve: Curves.easeOutCubic);
      },
    );
  }
}

class ServiceItem extends StatefulWidget {
  final Map<String, dynamic> data;
  final bool isSelected;
  final Duration animationDelay;
  final VoidCallback onTap;

  const ServiceItem({
    super.key,
    required this.data,
    required this.isSelected,
    required this.animationDelay,
    required this.onTap,
  });

  @override
  State<ServiceItem> createState() => _ServiceItemState();
}

class _ServiceItemState extends State<ServiceItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _bounceCtrl;

  @override
  void initState() {
    super.initState();
    _bounceCtrl = AnimationController(vsync: this, duration: 400.milliseconds);
  }

  @override
  void didUpdateWidget(covariant ServiceItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    // При изменении выбора запускаем "пружинистую" анимацию
    if (oldWidget.isSelected != widget.isSelected && widget.isSelected) {
      _bounceCtrl.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _bounceCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isSel = widget.isSelected;

    // Основной контейнер с анимированным скейлом от _bounceCtrl
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _bounceCtrl,
        builder: (context, child) {
          // Кривая "пружина" только при выделении, иначе возвращаем обычный размер
          double scale = isSel
              ? 1.0 +
                    (_bounceCtrl.value == 0.0
                        ? 0.0
                        : Curves.easeOutBack.transform(_bounceCtrl.value) *
                              0.03)
              : 1.0;
          return Transform.scale(scale: scale, child: child);
        },
        child:
            Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  height: isSel ? 56 : 48,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: isSel ? null : const Color(0xFF1C1C1E),
                    boxShadow: isSel
                        ? [
                            BoxShadow(
                              color: const Color(0xFFE91E63).withOpacity(0.35),
                              blurRadius: 20,
                              offset: const Offset(0, 6),
                            ),
                          ]
                        : [],
                    gradient: isSel
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
                  // Здесь используем AnimatedContainer только для плавного изменения размера и фона
                  // (можно оставить как есть, но для оптимизации убрали задержки flutter_animate)
                  // А текст, цена и кружок анимируем отдельно через AnimatedDefaultTextStyle и AnimatedContainer
                  child: _buildContent(isSel),
                )
                .animate() // анимация появления только при первом показе
                .fadeIn(delay: widget.animationDelay, duration: 300.ms)
                .slideX(begin: 0.05, end: 0, curve: Curves.easeOut),
      ),
    );
  }

  Widget _buildContent(bool isSel) {
    return Row(
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              AnimatedDefaultTextStyle(
                duration: 350.milliseconds,
                style: GoogleFonts.montserrat(
                  color: isSel ? Colors.black : Colors.white,
                  fontWeight: isSel ? FontWeight.w700 : FontWeight.w600,
                  fontSize: isSel ? 16 : 15,
                ),
                child: Text(widget.data['name']),
              ),
              const SizedBox(width: 8),
              AnimatedDefaultTextStyle(
                duration: 350.milliseconds,
                style: GoogleFonts.montserrat(
                  color: isSel ? Colors.black54 : Colors.white38,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
                child: Text(widget.data['time']),
              ),
            ],
          ),
        ),
        AnimatedDefaultTextStyle(
          duration: 350.milliseconds,
          style: GoogleFonts.montserrat(
            color: isSel ? Colors.black : Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: isSel ? 17 : 15,
          ),
          child: Text(widget.data['price']),
        ),
        const SizedBox(width: 12),
        // Кружок-галочка с живой анимацией
        AnimatedContainer(
          duration: 350.milliseconds,
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSel ? Colors.white : Colors.transparent,
            border: Border.all(
              color: isSel ? Colors.white : Colors.white24,
              width: isSel ? 6 : 1.5,
            ),
          ),
          child: isSel
              ? Icon(Icons.check, size: 12, color: const Color(0xFFE91E63))
                    .animate()
                    .scale(
                      delay: 150.ms,
                      duration: 250.ms,
                      curve: Curves.easeOutBack,
                    )
                    .rotate(
                      begin: -0.2,
                      end: 0,
                      delay: 150.ms,
                      duration: 250.ms,
                      curve: Curves.easeOutBack,
                    )
              : null,
        ),
      ],
    );
  }
}

class RootsLogo extends StatelessWidget {
  const RootsLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
