import 'package:barbershop/features/home/presentation/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../features/service/presentation/service_screen.dart';

Widget buildBottomNav(BuildContext context, int currentIndex) {
  return Hero(
    tag: 'custom_bottom_bar', // Shared Element анимация между экранами
    // Material нужен, чтобы при перелете не возникало желтых линий (ошибка рендера текста)
    child: Material(
      type: MaterialType.transparency,
      child: _CustomAnimatedBottomNav(currentIndex: currentIndex),
    ),
  );
}

class _CustomAnimatedBottomNav extends StatelessWidget {
  final int currentIndex;

  const _CustomAnimatedBottomNav({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
      height: 70,
      decoration: BoxDecoration(
        color: const Color.fromARGB(240, 28, 28, 30), // Темный стеклянный фон
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(120, 0, 0, 0),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _NavItem(
            context: context,
            icon: Icons.home_rounded,
            label: 'Главная',
            index: 0,
            currentIndex: currentIndex,
          ),
          _NavItem(
            context: context,
            icon: Icons.content_cut_rounded,
            label: 'Запись',
            index: 1,
            currentIndex: currentIndex,
          ),
          _NavItem(
            context: context,
            icon: Icons.person_rounded,
            label: 'Профиль',
            index: 2,
            currentIndex: currentIndex,
          ),
        ],
      ),
    );
  }
}

/// Вынесли кнопку в StatefulWidget для обработки анимации сжатия (Bounce) при нажатии
class _NavItem extends StatefulWidget {
  final BuildContext context;
  final IconData icon;
  final String label;
  final int index;
  final int currentIndex;

  const _NavItem({
    required this.context,
    required this.icon,
    required this.label,
    required this.index,
    required this.currentIndex,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  // Флаг, управляющий анимацией нажатия
  bool _isPressed = false;

  void _handleTap() async {
    if (widget.currentIndex == widget.index) return;

    // Имитация нажатия – уменьшаем, даём зрителю увидеть анимацию
    setState(() => _isPressed = true);

    // Короткая пауза, чтобы анимация успела отрисоваться
    await Future.delayed(const Duration(milliseconds: 80));

    // Возвращаем исходный размер перед переходом
    setState(() => _isPressed = false);

    // Даём завершиться возвратной анимации
    await Future.delayed(const Duration(milliseconds: 100));

    // Определяем целевой экран
    Widget targetScreen;
    if (widget.index == 0) {
      targetScreen = const WelcomeScreen();
    } else if (widget.index == 1) {
      targetScreen = const ServicesScreen();
    } else {
      return; // Профиль – заглушка
    }

    // Переход
    Navigator.pushReplacement(
      widget.context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => targetScreen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curve = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          );
          return FadeTransition(
            opacity: curve,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.05),
                end: Offset.zero,
              ).animate(curve),
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isSelected = widget.currentIndex == widget.index;

    return GestureDetector(
      // Обрабатываем только тап, без разделения на down/up
      onTap: _handleTap,
      // Для надёжности делаем область попадания полной
      behavior: HitTestBehavior.opaque,
      child: AnimatedScale(
        // При нажатии уменьшаемся до 85%, иначе 1.0
        scale: _isPressed ? 0.85 : 1.0,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.symmetric(
            horizontal: isSelected ? 20 : 12,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: isSelected ? null : Colors.transparent,
            gradient: isSelected
                ? const LinearGradient(
                    colors: [Color(0xFFFF4D94), Color(0xFFE91E63)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
          ),
          child: Row(
            children: [
              Icon(
                widget.icon,
                color: isSelected ? Colors.white : Colors.white54,
                size: 26,
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeOutCubic,
                child: SizedBox(
                  width: isSelected ? null : 0,
                  child: Padding(
                    padding: EdgeInsets.only(left: isSelected ? 8.0 : 0),
                    child: Text(
                      widget.label,
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
