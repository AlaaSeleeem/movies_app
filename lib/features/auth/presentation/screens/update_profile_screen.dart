import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  int _selectedAvatar = 0;
  bool _showAvatarGrid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back, color: AppColors.yellow, size: 22.sp),
        ),
        title: Text(
          'Pick Avatar',
          style: TextStyle(
            color: AppColors.yellow,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
            height: 1.2,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24.h),

            // ── Avatar ────────────────────────────────────────
            Center(
              child: GestureDetector(
                onTap: () => setState(() => _showAvatarGrid = !_showAvatarGrid),
                child: SizedBox(
                  width: 150.w,
                  height: 150.w,
                  child: ClipOval(
                    child: Image.asset(
                      AppAssets.avatars[_selectedAvatar],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),

            // ── Name Field ────────────────────────────────────
            _buildInputField(
              icon: AppAssets.nameIcon,
              hint: 'John Safwat',
            ),
            SizedBox(height: 14.h),

            // ── Phone Field ───────────────────────────────────
            _buildInputField(
              icon: AppAssets.phoneIcon,
              hint: '01200000000',
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 16.h),

            // ── Reset Password ────────────────────────────────
            Text(
              'Reset Password',
              style: TextStyle(
                color: AppColors.white,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                fontSize: 20.sp,
                height: 1.2,
              ),
            ),
            SizedBox(height: 24.h),

            // ── Avatar Grid ───────────────────────────────────
            if (_showAvatarGrid) _buildAvatarGrid(),

            SizedBox(height: 200.h),

            // ── Delete Account Button ─────────────────────────
            _buildButton(
              label: 'Delete Account',
              backgroundColor: AppColors.red,
              textColor: AppColors.white,
            ),
            SizedBox(height: 12.h),

            // ── Update Data Button ────────────────────────────
            _buildButton(
              label: 'Update Data',
              backgroundColor: AppColors.yellow,
              textColor: AppColors.black,
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  // ── Input Field ───────────────────────────────────────────
  Widget _buildInputField({
    required String icon,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      height: 55.h,
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: AppColors.grey),
      ),
      child: Row(
        children: [
          SizedBox(width: 16.w),
          Image.asset(icon, width: 30.w, height: 30.w),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              hint,
              style: TextStyle(
                color: AppColors.white,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                fontSize: 20.sp,
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Avatar Grid ───────────────────────────────────────────
  Widget _buildAvatarGrid() {
    return Container(
      width: double.infinity,
      height: 389.h,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 10.h,
          childAspectRatio: 108 / 105,
        ),
        itemCount: AppAssets.avatars.length,
        itemBuilder: (context, index) {
          final isSelected = _selectedAvatar == index;
          return GestureDetector(
            onTap: () => setState(() {
              _selectedAvatar = index;
              _showAvatarGrid = false;
            }),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: isSelected ? AppColors.yellowBorder : Colors.transparent,
                  width: 1,
                ),
              ),
              padding: EdgeInsets.all(9.r),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.asset(
                  AppAssets.avatars[index],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ── Button ────────────────────────────────────────────────
  Widget _buildButton({
    required String label,
    required Color backgroundColor,
    required Color textColor,
  }) {
    return Container(
      width: double.infinity,
      height: 55.h,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(15.r),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
          fontSize: 20.sp,
          height: 1.2,
        ),
      ),
    );
  }
}