import 'package:flutter/material.dart';

class NavBarItem {
  final IconData selectedIcon;
  final IconData unselectedIcon;
  final String label;

  NavBarItem({
    required this.selectedIcon,
    required this.unselectedIcon,
    required this.label,
  });
}

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  final double iconSize = 28.0;
  final double circleSize = 60.0;

  final List<NavBarItem> items = [
    NavBarItem(selectedIcon: Icons.home, unselectedIcon: Icons.home_outlined, label: 'Home'),
    NavBarItem(selectedIcon: Icons.favorite, unselectedIcon: Icons.favorite_border, label: 'Favorites'),
    NavBarItem(selectedIcon: Icons.shopping_bag, unselectedIcon: Icons.shopping_bag_outlined, label: 'Cart'),
    NavBarItem(selectedIcon: Icons.notifications, unselectedIcon: Icons.notifications_outlined, label: 'Notifications'),
    NavBarItem(selectedIcon: Icons.person, unselectedIcon: Icons.person_outline, label: 'Profile'),
  ];

  CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double itemWidth = screenWidth / items.length;
    final double circleXPos = (itemWidth * selectedIndex) + (itemWidth / 2) - (circleSize / 2);

    return SizedBox(
      height: 85,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: ClipPath(
              clipper: CustomNavBarClipper(
                selectedIndex: selectedIndex,
                itemWidth: itemWidth,
              ),
              child: Container(
                height: 70,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -2)),
                  ],
                ),
                child: Row(
                  children: List.generate(items.length, (index) {
                    return _buildNavItem(index, itemWidth);
                  }),
                ),
              ),
            ),
          ),

          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            left: circleXPos,
            top: -15,
            child: Container(
              width: circleSize,
              height: circleSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
                boxShadow: [
                  BoxShadow(color: Colors.blue.withOpacity(0.4), blurRadius: 10, spreadRadius: 2),
                ],
              ),
              child: Icon(items[selectedIndex].selectedIcon, color: Colors.white, size: iconSize),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, double itemWidth) {
    bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Container(
        width: itemWidth,
        height: 70,
        color: Colors.transparent,
        child: Icon(
          items[index].unselectedIcon,
          color: isSelected ? Colors.transparent : Colors.grey[600],
          size: iconSize,
        ),
      ),
    );
  }
}

class CustomNavBarClipper extends CustomClipper<Path> {
  final int selectedIndex;
  final double itemWidth;
  final double notchRadius = 35.0;
  final double notchDepth = 35.0;

  CustomNavBarClipper({required this.selectedIndex, required this.itemWidth});

  @override
  Path getClip(Size size) {
    final path = Path();
    final width = size.width;
    final height = size.height;
    final notchCenterX = (itemWidth * selectedIndex) + (itemWidth / 2);

    path.moveTo(0, 0);
    path.lineTo(notchCenterX - notchRadius * 1.5, 0);
    path.quadraticBezierTo(notchCenterX - notchRadius, 0, notchCenterX - notchRadius, notchDepth / 2);
    path.quadraticBezierTo(notchCenterX, notchDepth, notchCenterX + notchRadius, notchDepth / 2);
    path.quadraticBezierTo(notchCenterX + notchRadius, 0, notchCenterX + notchRadius * 1.5, 0);
    path.lineTo(width, 0);
    path.lineTo(width, height);
    path.lineTo(0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomNavBarClipper oldClipper) {
    return oldClipper.selectedIndex != selectedIndex;
  }
}