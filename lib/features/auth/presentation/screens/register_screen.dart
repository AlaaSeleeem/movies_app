import 'package:flutter/material.dart';
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
  // TextEditingController passwordController = TextEditingController(
  //     text: '123Aaa##'
  // );
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmVisible = false;

  final _formKey = GlobalKey<FormState>();

  bool isSecure = false;
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        leading: Icon(Icons.arrow_back, color: AppColors.yellow,),
        title:Text("Register", textAlign: TextAlign.center,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 10,
          children: [
            // the avatars may be edited
            Row(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(AppAssets.avatars[0]),
                  radius: 50,

                ),
                CircleAvatar(
                  backgroundImage: AssetImage(AppAssets.mainAvatar),
                  radius: 70,

                ),
                CircleAvatar(
                  backgroundImage: AssetImage(AppAssets.avatars[1]),
                  radius: 50,

                ),
              ]
            ),
            Form(
              key: formkey,
              child: Column(
                spacing: 20,
                children: [
                  // name field
                  TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.grey,
                      hintText: "Name",
                      hintStyle: TextStyle(color: AppColors.white, fontWeight: FontWeight.w400, fontSize: 16),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(
                          height: 20,
                          width: 20,
                          AppAssets.nameIcon,
                          color: AppColors.white,
                        ),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    // email field
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.grey,
                      hintText: "Email",
                      hintStyle: TextStyle(color: AppColors.white, fontWeight: FontWeight.w400, fontSize: 16),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.asset(
                            height: 20,
                            width: 20,
                            AppAssets.emailIcon,
                            color: AppColors.white,
                          ),
                        ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),

                  ),
                  // password field
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.grey,
                      hintText: " Password",
                      hintStyle: TextStyle(color: AppColors.white, fontWeight: FontWeight.w400, fontSize: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(
                          width: 20,
                          height: 20,
                          AppAssets.passwordIcon,
                          color: AppColors.white,
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

                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.grey,
                      hintText: " Confirm Password",
                      hintStyle: TextStyle(color: AppColors.white, fontWeight: FontWeight.w400, fontSize: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(
                          width: 20,
                          height: 20,
                          AppAssets.passwordIcon,
                          color: AppColors.white,
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isConfirmVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        color: AppColors.white,),
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
                      filled: true,
                      fillColor: AppColors.grey,
                      hintText: "Phone Number",
                      hintStyle: TextStyle(color: AppColors.white, fontWeight: FontWeight.w400, fontSize: 16),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(
                          height: 20,
                          width: 20,
                          AppAssets.phoneIcon,
                          color: AppColors.white,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    // email field
                  ),
                  // create Account btn
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.yellow,
                            padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: (){},
                        child: Text("Create Account",
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: 16,
                            ))),
                  ),
                  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account? ",
                    style: TextStyle(color: Colors.white, fontSize: 16),
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
                        fontSize: 14,
                        fontWeight: FontWeight.w400
                      )
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: AppColors.yellow,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                  ),
                ],
              ),
                  Container(
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.yellowBorder, width: 2),

                    ),
                    child: Row(
                      spacing: 10,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(AppAssets.enIcon),
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
