// File: core/widgets/custom_button.dart

import 'package:flutter/material.dart';
import '/core/constants/colors.dart';

class CustomButton extends StatelessWidget {
  // It now takes a Widget as a child, making it more flexible.
  final Widget child;
  final Function()? onPressed;

  const CustomButton({
    super.key,
    required this.child, // The child widget is now required.
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      // Giving the button a fixed height prevents the layout from changing
      // when switching between the text and the smaller progress indicator.
      height: 50,
      child: TextButton(
        // The onPressed callback is passed directly.
        // If it's null (like when _isLoading is true), the button is automatically disabled.
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: AppColors.button,
          // This color is used when the button is disabled.
          disabledBackgroundColor: AppColors.button.withOpacity(0.7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
        ),
        // The child widget passed to the constructor is placed here.
        child: child,
      ),
    );
  }
}
