import 'package:flutter/material.dart';

import '../../features/home/data/models/brand_model.dart';
import '../constants/colors.dart';

class BrandListItem extends StatelessWidget {
  const BrandListItem({
    super.key,
    required this.brand,
    required this.isSelected,
  });

  final BrandModel brand;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryBlue : AppColors.white,
          borderRadius: BorderRadius.circular(50.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.white : AppColors.backgroundAppbar,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(0.5),
                child: Image.asset(
                  brand.logoAsset,
                  errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error, color: Colors.red),
                ),
              ),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
              child: Row(
                children: [
                  if (isSelected) ...[
                    const SizedBox(width: 8),
                    Text(
                      brand.name,
                      style: const TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}