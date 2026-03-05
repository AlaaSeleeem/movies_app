/*import 'package:flutter/material.dart';
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
}*/


//....................
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../bloc/auth_bloc.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back, color: AppColors.yellow, size: 22.sp),
        ),
        title: const Text('Forget Password'),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.green),
            );
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 430.h,
                      child: Image.asset(AppAssets.forgotPassword, fit: BoxFit.contain),
                    ),
                    TextFormField(
                      controller: emailController,
                      validator: (value) {
                        // دا الشرط بتاعنا
                        if (value == null || value.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email';
                        }
                        return null; //...............
                      },
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: AppColors.white, fontSize: 16.sp),
                      decoration: InputDecoration(
                        hintText: 'Email',
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(12.r),
                          child: Image.asset(AppAssets.emailIcon, width: 31.w, height: 25.h, color: AppColors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    SizedBox(
                      width: double.infinity,
                      height: 55.h,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            // ...........
                            context.read<AuthBloc>().add(
                              PasswordResetRequested(email: emailController.text.trim()),
                            );
                          }
                        },
                        // ...........
                        child: Text(
                          'Verify Email',
                          style: TextStyle(color: AppColors.black, fontSize: 20.sp),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
