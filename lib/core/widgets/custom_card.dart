import 'package:final_project/core/constants/colors.dart';
import 'package:final_project/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import '../../features/product_details/data/models/product_model.dart';

class CustomCard extends StatelessWidget {
  final ProductModel model;
  final VoidCallback? onTap;

  const CustomCard({
    super.key,
    required this.model,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // 1. Reduced width for a more compact card
        width: 160,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 2. Used Expanded to let the image take available space, helping create a square look
                  Expanded(
                    child: Center(
                      child: Image.network(
                        model.image,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => const Center(
                          child: Icon(Icons.image_not_supported,
                              color: Colors.grey, size: 40),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // 3. Adjusted text and spacing for the smaller size
                  const CustomText(
                    text: 'Best Seller',
                    fontSize: 12,
                    color: AppColors.lightBlue,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(height: 4),
                  CustomText(
                    text: model.name,
                    fontSize: 16,
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  CustomText(
                    text: '\$${model.price}',
                    fontSize: 16,
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
            // 4. Redesigned the "Add" button to be smaller and match the new card style
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 45,
                height: 40,
                decoration: const BoxDecoration(
                  color: AppColors.lightBlue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
