import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

extension CustomAnimateExtensions<T extends AnimateManager<T>> on T {
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
