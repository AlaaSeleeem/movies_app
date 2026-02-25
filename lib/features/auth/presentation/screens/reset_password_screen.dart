import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/features/auth/presentation/screens/login_screen.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(
              context
            );
          },
          child: Icon(Icons.arrow_back, color: AppColors.yellow, size: 22.sp),
        ),

        title: const Text('Forget Password'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Image ─────────────────────────────────────────
            SizedBox(
              width: double.infinity,
              height: 430.h,
              child: Image.asset(AppAssets.forgotPassword, fit: BoxFit.contain),
            ),

            // ── Email Field ───────────────────────────────────
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                hintText: 'Email',
                prefixIcon: Padding(
                  padding: EdgeInsets.all(12.r),
                  child: Image.asset(
                    AppAssets.emailIcon,
                    width: 31.w,
                    height: 25.h,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),

            // ── Verify Email Button ───────────────────────────
            SizedBox(
              width: double.infinity,
              height: 55.h,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Verify Email',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
