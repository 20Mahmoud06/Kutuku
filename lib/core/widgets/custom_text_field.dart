import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.text,
    this.onChanged, // Add onChanged callback
  });

  final String text;
  final ValueChanged<String>? onChanged; // Define the callback type

  @override
  Widget build(BuildContext context) {
    final outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(50.0),
      borderSide: const BorderSide(color: AppColors.border, width: 1.5),
    );

    final focusedOutlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(50.0),
      borderSide: BorderSide(color: AppColors.grey.withOpacity(0.5), width: 1.5),
    );

    return TextField(
      onChanged: onChanged, // Pass the callback to the underlying TextField
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search, size: 25, color: AppColors.grey),
        border: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        focusedBorder: focusedOutlineInputBorder,
        isDense: true,
        hintText: text,
        hintStyle: const TextStyle(color: AppColors.grey, fontSize: 16),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
      ),
      style: const TextStyle(color: AppColors.black, fontSize: 16),
      cursorColor: AppColors.black,
    );
  }
}
