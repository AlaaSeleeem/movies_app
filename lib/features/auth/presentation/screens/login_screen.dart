import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final themeColor = const Color(0xFFF6BD00);
    final fieldColor = const Color(0xFF252525);

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),

              // --- App Logo ---
              Image.asset(
                'assets/images/main_logo.png',
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),

              // --- Email Field ---
              _buildTextField(
                hint: "Email",
                icon: Icons.email,
                fillColor: fieldColor,
              ),
              const SizedBox(height: 16),

              // --- Password Field ---
              _buildTextField(
                hint: "Password",
                icon: Icons.lock,
                fillColor: fieldColor,
                isPassword: true,
                obscureText: _obscurePassword,
                onSuffixTap: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),

              // --- Forget Password ---
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Forget Password ?",
                    style: TextStyle(color: themeColor, fontSize: 14),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // --- Login Button ---
              _buildActionButton(
                label: "Login",
                color: themeColor,
                textColor: Colors.black,
                onPressed: () {},
              ),
              const SizedBox(height: 20),

              // --- Create Account Link ---
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don’t Have Account ? ",
                    style: TextStyle(color: Colors.white70),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Create One",
                      style: TextStyle(
                        color: themeColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),

              // --- Divider ---
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: themeColor.withOpacity(1.0),
                      endIndent: 10,
                    ),
                  ),
                  Text("OR", style: TextStyle(color: themeColor)),
                  Expanded(child: Divider(color: themeColor, indent: 10)),
                ],
              ),
              const SizedBox(height: 25),

              // --- Google Login ---
              _buildActionButton(
                label: "Login With Google",
                color: themeColor.withOpacity(1.0),
                textColor: Colors.black,
                icon: Image.asset(
                  'assets/icons/google_icon.png',
                  width: 30,
                  height: 30,
                ),
                onPressed: () {},
              ),
              const SizedBox(height: 40),

              // --- Language Toggle ---
              _buildLanguageToggle(themeColor),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Helper: Text Field Builder
  Widget _buildTextField({
    required String hint,
    required IconData icon,
    required Color fillColor,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onSuffixTap,
  }) {
    return TextField(
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        prefixIcon: Icon(icon, color: Colors.white),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white,
                ),
                onPressed: onSuffixTap,
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // Large Button Builder
  Widget _buildActionButton({
    required String label,
    required Color color,
    required Color textColor,
    Widget? icon,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[icon, const SizedBox(width: 8)],
            Text(
              label,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Language Toggle UI
  Widget _buildLanguageToggle(Color themeColor) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: themeColor, width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image(
            image: AssetImage('assets/icons/EN_icon.png'),
            width: 28,
            height: 28,
          ),
          Image(
            image: AssetImage('assets/icons/EG_icon.png'),
            width: 28,
            height: 28,
          ),
        ],
      ),
    );
  }
}
