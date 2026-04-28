// lib/core/custom_animations.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Создаем кастомные расширения поверх flutter_animate,
/// чтобы легко применять их к любым виджетам.
extension CustomAnimateExtensions<T extends AnimateManager<T>> on T {
  /// Эффект богатого появления (Slide вниз + Fade + красивый Shimmer-блик)
  T richIntro({Color? shimmerColor}) {
    return fadeIn(duration: 600.ms, curve: Curves.easeOut)
        .slideY(begin: -0.2, end: 0, duration: 600.ms, curve: Curves.easeOut)
        .shimmer(
          color: shimmerColor ?? Colors.white54,
          delay: 400.ms,
          duration: 1200.ms,
          curve: Curves.easeInOut,
        );
  }

  /// Стандартное плавное появление (Slide вверх + Fade)
  T defaultIntro({Duration delay = Duration.zero}) {
    return fadeIn(
      delay: 200.ms + delay,
      duration: 500.ms,
      curve: Curves.easeOut,
    ).slideY(
      begin: 0.1,
      end: 0,
      delay: 200.ms + delay,
      duration: 500.ms,
      curve: Curves.easeOut,
    );
  }
}
