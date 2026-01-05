import 'package:flutter/material.dart';
import '../services/auth_services.dart';
import 'home_screen.dart';
import 'login_screen.dart';


class SplashScreen extends StatefulWidget {
   SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  void _checkLogin() async {
    final isLoggedIn = await AuthService.isLoggedIn();

    await Future.delayed( Duration(seconds: 1));

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => isLoggedIn ?  HomeScreen() :  LoginScreen(),
      ),
    );
  }
  @override
Widget build(BuildContext context) {
  return  Scaffold(
    backgroundColor: const Color.fromARGB(255, 251, 183, 183),
    body: Center(
      child: CircularProgressIndicator(),
    ),
  );
}
}
