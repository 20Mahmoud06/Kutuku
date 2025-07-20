import 'package:flutter/material.dart';
import '/core/constants/colors.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final Function()? onPressed;

  const CustomButton({
    super.key,
    required this.child,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: AppColors.button,
          disabledBackgroundColor: AppColors.button.withOpacity(0.7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
        ),
        child: child,
      ),
    );
  }
}
