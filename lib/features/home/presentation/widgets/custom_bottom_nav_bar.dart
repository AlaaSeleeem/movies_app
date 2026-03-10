import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return Container(
      width: 413.w,
      height: 61.h,
      margin: EdgeInsets.only(left: 9.w, right: 9.w, bottom: 20.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(context, assetPath: AppAssets.homeIcon, index: 0),
          _buildNavItem(context, assetPath: AppAssets.searchIcon, index: 1),
          _buildNavItem(context, assetPath: AppAssets.exploreIcon, index: 2),
          _buildNavItem(context, assetPath: AppAssets.profileIcon, index: 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, {
    required String assetPath,
    required int index,
  }) {
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Image.asset(
        assetPath,
        width: 26.w,
        height: 23.h,
        color: selectedIndex == index ? AppColors.yellow : Colors.grey.shade700,
      ),
    );
  }
}