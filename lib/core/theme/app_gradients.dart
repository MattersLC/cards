import 'package:credit_cards_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppGradients {
  final List<Gradient> cardGradients = [
    LinearGradient(
      colors: [Color(0xFFFFD700), Color(0xFFB8860B), Color(0xFFF5DEB3)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    SweepGradient(
      colors: [
        Color(0xFF232526),
        Color(0xFF414345),
        Color(0xFF283E51),
        Color(0xFF485563),
      ],
      center: Alignment.center,
      startAngle: 0.0,
      endAngle: 3.14,
    ),
    LinearGradient(
      colors: [Color(0xFF43CEA2), Color(0xFF185A9D)],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
    ),
    RadialGradient(
      colors: [Color(0xFFB24592), Color(0xFFF15F79), Color(0xFF6D6027)],
      center: Alignment.center,
      radius: 1.2,
    ),
    LinearGradient(
      colors: [Color(0xFF232526), Color(0xFF414345), Color(0xFF000000)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    RadialGradient(
      colors: [
        AppPallete.gradient1,
        AppPallete.gradient1,
        AppPallete.gradient2,
        AppPallete.gradient3,
      ],
      center: Alignment.topLeft,
      radius: 1.0,
    ),
    SweepGradient(
      colors: [
        Color(0xFF0F2027),
        Color(0xFF2C5364),
        Color(0xFF203A43),
        Color(0xFF0F2027),
      ],
      center: Alignment.center,
      startAngle: 0.0,
      endAngle: 6.28,
    ),
  ];
}
