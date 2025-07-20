import 'package:final_project/core/widgets/custom_text.dart';
import 'package:final_project/features/product_details/data/models/sizes_model.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

class SizesContainer extends StatelessWidget {
  const SizesContainer({
    super.key,
    required this.sizesModel,
    required this.isSelected,
    required this.onTap,
  });

  final SizesModel sizesModel;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? AppColors.lightBlue : AppColors.backgroundAppbar,
        ),
        child: Center(
          child: CustomText(
            text: sizesModel.size,
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: isSelected ? AppColors.white : AppColors.grey,
          ),
        ),
      ),
    );
  }
}