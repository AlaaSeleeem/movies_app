import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GenreCard extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const GenreCard({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        margin: EdgeInsets.only(right: 10.w),
        height: 48.h,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF6BD00) : Colors.transparent,
          borderRadius: BorderRadius.circular(16.r),
          border: isSelected ? null : Border.all(color: const Color(0xFFF6BD00), width: 2),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            fontSize: 20.sp,
            color: isSelected ? Colors.black : const Color(0xFFF6BD00),
          ),
        ),
      ),
    );
  }
}