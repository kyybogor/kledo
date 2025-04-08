import 'package:flutter/material.dart';
import 'package:flutter_application_kledo/Login/loginScreen.dart'; // Sesuaikan path

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD6D6D6), // abu-abu terang
      body: Center(
        child: Image.asset(
          'assets/images/kledo_logo.png', // pastikan path sesuai
          width: 180,
        ),
      ),
    );
  }
}
