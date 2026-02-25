import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/features/auth/presentation/screens/reset_password_screen.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_assets.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_text_field.dart';
import 'update_profile_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 60.h),
              Image.asset(AppAssets.loginIcon, width: 100.w, height: 100.w),
              SizedBox(height: 40.h),
              AuthTextField(hint: 'Email', icon: Icons.email_rounded),
              SizedBox(height: 16.h),
              AuthTextField(
                hint: 'Password',
                icon: Icons.lock_rounded,
                isPassword: true,
                obscureText: _obscurePassword,
                onSuffixTap: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const ResetPasswordScreen()),
                    );
                  },
                  child: Text(
                    'Forget Password ?',
                    style: TextStyle(color: AppColors.yellow, fontSize: 14.sp),
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              AuthButton(
                label: 'Login',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const UpdateProfileScreen()),
                  );
                },
              ),
              SizedBox(height: 20.h),
              _buildCreateAccountRow(),
              SizedBox(height: 25.h),
              _buildDivider(),
              SizedBox(height: 25.h),
              AuthButton(
                label: 'Login With Google',
                icon: Image.asset(AppAssets.googleIcon, width: 22.w),
                onPressed: () {},
              ),
              SizedBox(height: 35.h),
              _buildLanguageToggle(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCreateAccountRow() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
    Text(
    'Dont Have Account ? ',
    style: TextStyle(color: AppColors.white, fontSize: 14.sp),
    ),
    GestureDetector(
    onTap: () {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const RegisterScreen()),
    );
    },
    child: Text(
    'Create One',
    style: TextStyle(
    color: AppColors.yellow,
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
    ),
    ),
    ),
    ],
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: AppColors.yellow)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Text(
            'OR',
            style: TextStyle(
              color: AppColors.yellow,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(child: Divider(color: AppColors.yellow)),
      ],
    );
  }

  Widget _buildLanguageToggle() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(color: AppColors.yellow, width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(AppAssets.enIcon, width: 26.w),
          SizedBox(width: 10.w),
          Image.asset(AppAssets.egIcon, width: 26.w),
        ],
      ),
    );
  }
}