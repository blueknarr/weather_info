import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xfff3f3f3),
      child: Center(
        child: Image.asset(
          'assets/images/logo.png',
        ),
      ),
    );
  }
}
