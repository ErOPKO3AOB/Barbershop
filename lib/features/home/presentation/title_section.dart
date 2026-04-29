import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleSection extends StatefulWidget {
  const TitleSection({super.key});

  @override
  State<TitleSection> createState() => _TitleSectionState();
}

class _TitleSectionState extends State<TitleSection>
    with TickerProviderStateMixin {
  late AnimationController _introController;
  late AnimationController _loopController;
  late Animation<Offset> _slideFirst;
  late Animation<Offset> _slideSecond;

  final List<WordSettings> words = [
    WordSettings(
      text: 'ОБНОВИ',
      animMs: 1400,
      delayBefore: 600,
      scale: 1.00625,
    ),
    WordSettings(text: 'СВОЙ', animMs: 1400, delayBefore: 70, scale: 1.00625),
    WordSettings(text: 'СТИЛЬ', animMs: 2500, delayBefore: 0, scale: 1.025),
  ];

  final int finalPause = 100;
  late int totalDuration;

  @override
  void initState() {
    super.initState();
    totalDuration =
        words.fold(0, (sum, w) => sum + w.animMs + w.delayBefore) + finalPause;

    // Интро: выезд за 800 мс
    _introController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Цикл пульсации
    _loopController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: totalDuration),
    );

    // Первая строка: выезжает из-за левого края (с запасом)
    _slideFirst = Tween<Offset>(
      begin: const Offset(-1.5, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _introController, curve: Curves.easeOut));

    // Вторая строка: выезжает из-за правого края
    _slideSecond = Tween<Offset>(
      begin: const Offset(1.5, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _introController, curve: Curves.easeOut));

    // Запуск интро с задержкой 600 мс
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) _introController.forward();
    });

    _introController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (mounted) _loopController.repeat();
      }
    });
  }

  @override
  void dispose() {
    _introController.dispose();
    _loopController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = GoogleFonts.montserrat(
      color: Colors.white,
      fontSize: 30,
      fontWeight: FontWeight.w900,
      height: 1.1,
    );

    // Основной контент (будет обёрнут в ClipRect только на время интро)
    final content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ПЕРВАЯ СТРОКА
        SlideTransition(
          position: _slideFirst,
          child: AnimatedBuilder(
            animation: _loopController,
            builder: (context, _) {
              final double currentMs = _loopController.value * totalDuration;
              return _buildWord(0, textStyle, currentMs);
            },
          ),
        ),
        const SizedBox(height: 15),
        // ВТОРАЯ СТРОКА
        SlideTransition(
          position: _slideSecond,
          child: AnimatedBuilder(
            animation: _loopController,
            builder: (context, _) {
              final double currentMs = _loopController.value * totalDuration;
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildWord(1, textStyle, currentMs),
                  const SizedBox(width: 12),
                  _buildWord(2, textStyle, currentMs),
                ],
              );
            },
          ),
        ),
      ],
    );

    // Динамически убираем ClipRect после завершения интро, чтобы текст не обрезался
    return AnimatedBuilder(
      animation: _introController,
      builder: (context, child) {
        if (_introController.isCompleted) {
          // После интро анимация пульсации может выходить за рамки — обрезание не нужно
          return child!;
        } else {
          return ClipRect(child: child);
        }
      },
      child: content,
    );
  }

  Widget _buildWord(int index, TextStyle style, double currentMs) {
    final WordSettings settings = words[index];

    int startTime = 0;
    for (int i = 0; i <= index; i++) {
      startTime += words[i].delayBefore;
      if (i < index) startTime += words[i].animMs;
    }
    int endTime = startTime + settings.animMs;

    double scale = 1.0;
    double sidePadding = 0.0;
    Color wordColor = style.color ?? Colors.white;

    if (currentMs >= startTime && currentMs <= endTime) {
      double localT = (currentMs - startTime) / settings.animMs;

      // Живая плавная пульсация
      double baseCurve = Curves.easeInOut.transform(localT);
      double bell = math.sin(baseCurve * math.pi);
      scale = 1.0 + (settings.scale - 1.0) * bell;
      sidePadding = 12.0 * bell;

      const double extraScale = 0.15;
      double slowFactor = math.sin(localT * math.pi) * 0.7;
      scale += extraScale * slowFactor.clamp(0.0, 1.0);

      // Цветовой акцент (красноватый оттенок)
      const Color shimmerColor = Color.fromARGB(255, 230, 100, 100);

      double colorIntensity = slowFactor.clamp(0.0, 1.0);
      wordColor = Color.lerp(Colors.white, shimmerColor, colorIntensity)!;
    }

    return Transform.scale(
      scale: scale,
      child: Text(settings.text, style: style.copyWith(color: wordColor)),
    );
  }
}

class WordSettings {
  final String text;
  final int animMs;
  final int delayBefore;
  final double scale;

  const WordSettings({
    required this.text,
    this.animMs = 600,
    this.delayBefore = 200,
    this.scale = 1.2,
  });
}
