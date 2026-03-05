import 'package:flutter/material.dart';
// استيراد الـ Widget الخاص بكِ من مكانه الصحيح
import '../widgets/custom_bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // متغير لتتبع أي تاب نشط حاليًا
  int _selectedIndex = 0;

  // دالة لتغيير الـ index عند الضغط على أيقونة
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // هذا الجزء ستقوم زميلتك ببنائه لاحقًا
      body: Center(
        child: Text(
          'Screen Index: $_selectedIndex',
          style: const TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),

      // هنا يتم استخدام الـ Widget الخاص بكِ وتمرير الوظائف له
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}