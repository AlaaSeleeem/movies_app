import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/cache/cache_helper.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domian/entities/register_request.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  int _selectedAvatarIndex = 1;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  //UI State
  bool _isPasswordVisible = false;
  bool _isConfirmVisible = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back, color: AppColors.yellow),
        ),
        title: const Text(
          "Register",
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.white),
        ),
      ),
      //  to handle success/error side-effects
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            if (state.token != null) CacheHelper.saveToken(state.token!);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Success! Account Created"),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
            );
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              spacing: 10.sp,
              children: [
                _buildSelectableAvatars(),
                Form(
                  key: _formKey,
                  child: Column(
                    spacing: 20.sp,
                    children: [
                      // Name field
                      TextFormField(
                        controller: _nameController,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(color: AppColors.white),
                        decoration: InputDecoration(
                          hintText: "Name",
                          hintStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Image.asset(
                              AppAssets.nameIcon,
                              height: 20.sp,
                              width: 20.sp,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Name is required";
                          }
                          return null;
                        },
                      ),
                      // Email field
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(color: AppColors.white),
                        decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Image.asset(
                              AppAssets.emailIcon,
                              height: 20.sp,
                              width: 20.sp,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Email is required";
                          }
                          if (!value.contains("@")) {
                            return "Please enter a valid email";
                          }
                          return null;
                        },
                      ),
                      // Password field
                      TextFormField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(color: AppColors.white),
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: const TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Image.asset(
                              AppAssets.passwordIcon,
                              width: 20.sp,
                              height: 20.sp,
                            ),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: AppColors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter password";
                          }
                          if (value.length < 6) {
                            return "Password must be at least 6 characters";
                          }
                          return null;
                        },
                      ),
                      // Confirm Password Field
                      TextFormField(
                        controller: _confirmController,
                        obscureText: !_isConfirmVisible,
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(color: AppColors.white),
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
                          hintStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Image.asset(
                              AppAssets.passwordIcon,
                              width: 20.sp,
                              height: 20.sp,
                            ),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isConfirmVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: AppColors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                _isConfirmVisible = !_isConfirmVisible;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value != _passwordController.text) {
                            return "Passwords do not match";
                          }
                          return null;
                        },
                      ),
                      // Phone field
                      TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.done,
                        style: const TextStyle(color: AppColors.white),
                        decoration: InputDecoration(
                          hintText: "Phone Number",
                          hintStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Image.asset(
                              AppAssets.phoneIcon,
                              height: 20.sp,
                              width: 20.sp,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Phone number is required";
                          }
                          if (value.length < 9) {
                            return "phone number  must be at least 9 characters";
                          }
                          return null;
                        },
                      ),

                      // Create Account Button
                      SizedBox(
                        width: double.infinity,
                        child: BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            if (state is AuthLoading) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.yellow,
                                ),
                              );
                            }
                            return ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  final data = RegisterRequest(
                                    name: _nameController.text,
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    phone: _phoneController.text,
                                    avaterId: _selectedAvatarIndex,
                                  );
                                  context.read<AuthBloc>().add(
                                    AuthActionEventRegister(request: data),
                                  );
                                }
                              },
                              child: Text(
                                "Create Account",
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 16.sp,
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      // Login
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account? ",
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 16,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const LoginScreen(),
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(0, 0),
                              textStyle: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color: AppColors.yellow,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Language Switcher
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.r),
                          border: Border.all(
                            color: AppColors.yellowBorder,
                            width: 2,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.yellow,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(50.r),
                              ),
                              child: CircleAvatar(
                                radius: 16.r,
                                backgroundImage: AssetImage(AppAssets.enIcon),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            CircleAvatar(
                              radius: 16.r,
                              backgroundImage: AssetImage(AppAssets.egIcon),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectableAvatars() {
    return SizedBox(
      height: 130.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: AppAssets.avatars.length,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemBuilder: (context, index) {
          final bool isSelected = _selectedAvatarIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedAvatarIndex = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.yellow : Colors.transparent,
                  width: 3.w,
                ),
              ),
              child: CircleAvatar(
                radius: isSelected ? 55.r : 40.r,
                backgroundImage: AssetImage(AppAssets.avatars[index]),
              ),
            ),
          );
        },
      ),
    );
  }
}
