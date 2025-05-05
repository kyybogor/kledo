import 'package:flutter/material.dart';
import 'package:flutter_application_kledo/Splashscreen/splashscreen.dart'; // Sesuaikan path

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hayami',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      //home: const Splashscreen(),
      home: const Splashscreen()
    );
  }
}
