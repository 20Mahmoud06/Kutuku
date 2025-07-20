import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'custom_text.dart';

class GoogleSigninButton extends StatelessWidget {

  final String text;
  final double fontSize;
  final Color color;
  final void Function()? onPressed;

  GoogleSigninButton({
    required this.text ,
    this.fontSize = 18.0,
    this.onPressed,
    this.color = AppColors.black,
  });


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(50.0),
          border: Border.all(color: AppColors.border, width: 1.5),
        ),
        width: double.infinity,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/google.png',
              width: 30,
              height: 30,
            ),
            const SizedBox(width: 10.0),
            CustomText(
                text: text,
                fontSize: fontSize,
                color: color,
            ),
          ],
        )
      ),
    );
  }
}

