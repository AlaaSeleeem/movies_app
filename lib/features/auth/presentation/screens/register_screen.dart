import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/constants/app_assets.dart';
import 'package:movies_app/core/constants/app_colors.dart';
import 'package:movies_app/core/theme/app_theme.dart';
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController(
      text: 'alaa@tech.ly'
  );
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmVisible = false;
  bool isSecure = false;
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        leading: Icon(Icons.arrow_back, color: AppColors.yellow,),
        title:Text("Register", textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 10.sp,
          children: [
            // the avatars may be edited to be scrollable
            Row(
              spacing: 20.sp,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(AppAssets.avatars[0]),
                  radius: 40.sp,
                ),
                CircleAvatar(
                  backgroundImage: AssetImage(AppAssets.mainAvatar),
                  radius: 60.sp,
                ),
                CircleAvatar(
                  backgroundImage: AssetImage(AppAssets.avatars[1]),
                  radius: 40.sp,
                ),
              ]
            ),
            Form(
              key: formkey,
              child: Column(
                spacing: 20.sp,
                children: [
                  // name field
                  TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "Name",
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(
                          height: 20.sp,
                          width: 20.sp,
                          AppAssets.nameIcon,
                        ),
                      ),
                    ),
                    // email field
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "Email",
                      prefixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.asset(
                            height: 20.sp,
                            width: 20.sp,
                            AppAssets.emailIcon,
                          ),
                        ),
                    ),

                  ),
                  // password field
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      hintText: " Password",
                      hintStyle: TextStyle(color: AppColors.white, fontWeight: FontWeight.w400, fontSize: 16),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(
                          width: 20.sp,
                          height: 20.sp,
                          AppAssets.passwordIcon,
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
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

                    decoration: InputDecoration(
                      hintText: " Confirm Password",
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(
                          width: 20.sp,
                          height: 20.sp,
                          AppAssets.passwordIcon,
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isConfirmVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
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
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "Phone Number",
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(
                          height: 20.sp,
                          width: 20.sp,
                          AppAssets.phoneIcon,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    // email field
                  ),
                  // create Account btn
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: (){},
                        child: Text("Create Account",
                            style: TextStyle(
                                color: AppColors.black,
                              fontSize: 16.sp,
                            ))),
                  ),
                  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account? ",
                    style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16),
                  ),
                  TextButton(
                    onPressed: () {
                      //should be edited later
                      Navigator.pushNamed(context, '/login');
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 0),
                      textStyle: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400
                      )
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
                  Container(
                    width: 90.sp,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.sp),
                      border: Border.all(color: AppColors.yellowBorder, width: 2.sp),

                    ),
                    child: Row(
                      spacing: 10.sp,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.yellow, width: 3.sp),
                            borderRadius: BorderRadius.circular(50.sp)
                          ),
                          child: CircleAvatar(
                            backgroundImage: AssetImage(AppAssets.enIcon),
                          ),
                        ),
                        CircleAvatar(
                          backgroundImage: AssetImage(AppAssets.egIcon),
                        ),
                      ]
                    ),
                  )

                  ],

              ),
            ),
          ],
        ),
      ),
    );
  }
}
