import 'package:flutter/material.dart';

import '../constants/colors.dart';

class PageIndicatorDot extends StatelessWidget {
  final bool isActive;

  const PageIndicatorDot({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 8,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
        color: isActive ? AppColors.button : AppColors.lightGrey,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}