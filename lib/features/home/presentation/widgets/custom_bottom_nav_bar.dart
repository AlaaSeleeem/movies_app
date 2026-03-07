import 'package:flutter/material.dart';
import 'package:movies_app/core/constants/app_assets.dart';
import 'package:movies_app/core/constants/app_colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onItemTapped,

      // --- تصميم نهائي مطابق 100% لفيجما ---
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color(0xFF1A1A1A),
      showSelectedLabels: false,
      showUnselectedLabels: false,

      items: [
        // --- الأيقونة الأولى: Home ---
        _buildNavItem(
          assetPath: AppAssets.homeIcon, // <-- استخدمنا الاسم الصحيح
          label: 'Home',
          index: 0,
        ),

        // --- الأيقونة الثانية: Search ---
        _buildNavItem(
          assetPath: AppAssets.searchIcon, // <-- استخدمنا الاسم الصحيح
          label: 'Search',
          index: 1,
        ),

        // --- الأيقونة الثالثة: Explore ---
        _buildNavItem(
          assetPath: AppAssets.exploreIcon, // <-- استخدمنا الاسم الصحيح
          label: 'Explore',
          index: 2,
        ),

        // --- الأيقونة الرابعة: Profile ---
        _buildNavItem(
          assetPath: AppAssets.profileIcon, // <-- استخدمنا الاسم الصحيح
          label: 'Profile',
          index: 3,
        ),
      ],
    );
  }

  BottomNavigationBarItem _buildNavItem({
    required String assetPath,
    required String label,
    required int index,
  }) {
    return BottomNavigationBarItem(
      icon: GestureDetector(
        onTap: () {
          onItemTapped(index);
        },
        child: Image.asset(
          assetPath,
          width: 28,
          height: 28,
          color: selectedIndex == index ? AppColors.yellow : Colors.grey.shade700,
        ),
      ),
      label: label,
    );
  }
}