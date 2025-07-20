import 'package:final_project/core/constants/colors.dart';
import 'package:final_project/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppbar({
    super.key,
    this.rightIcon,
    required this.leftIcon,
    required this.titleText,
    this.showLocation = false,
    this.onLeftIconPressed,
  });

  final IconData? rightIcon;
  final IconData leftIcon;
  final String titleText;
  final bool showLocation;
  final VoidCallback? onLeftIconPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.backgroundAppbar,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(leftIcon, color: AppColors.black),
            onPressed: onLeftIconPressed,
          ),
        ),
      ),
      title: showLocation
          ? Column(
        children: [
          CustomText(
            text: 'Store location',
            fontSize: 14,
            color: AppColors.grey,
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_pin,
                color: AppColors.lightOrange,
                size: 20,
              ),
              const SizedBox(width: 4),
              CustomText(
                text: titleText,
                fontSize: 16,
                color: AppColors.black,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ],
      )
          : Center(
        child: CustomText(
          text: titleText,
          fontSize: 20,
          color: AppColors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      actions: [
        if (rightIcon != null)
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(rightIcon, color: AppColors.black),
              ),
            ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
}
