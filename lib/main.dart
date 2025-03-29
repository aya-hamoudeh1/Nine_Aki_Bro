import 'package:flutter/material.dart';
import 'package:nine_aki_bro/splash/splash_screen.dart';

void main() {
  runApp(const NineAkiBro());
}

class NineAkiBro extends StatelessWidget {
  const NineAkiBro({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Playfair Display',
      ),
      home: const SplashScreen(),
    );
  }
}
