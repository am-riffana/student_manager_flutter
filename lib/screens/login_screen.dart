import 'package:flutter/material.dart';
import '../services/auth_services.dart';
import 'home_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  void _login() async {
    if (usernameCtrl.text == 'admin' && passwordCtrl.text == '1234') {
      await AuthService.login();
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) =>  HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text('Invalid username or password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 219, 224, 255),
      appBar: AppBar(title:  Text('Login')),
      body: Padding(
        padding:  EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: usernameCtrl, 
              decoration:  InputDecoration
              (labelText: 'Username'),
            ),
            TextField(
              controller: passwordCtrl, 
              decoration:  InputDecoration(labelText: 'Password'), 
              obscureText: true
            ),
             SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login, 
              child:  Text('Login')),
          ],
        ),
      ),
    );
  }
}
