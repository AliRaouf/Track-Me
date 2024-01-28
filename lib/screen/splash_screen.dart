import 'package:flutter/material.dart';
import 'package:track_me/screen/start_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
        const Duration(seconds: 3),
            () =>
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const StartScreen()),
            ));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: const Color(0xfffafafa),
      body: Center(
        child: Image.asset("assets/images/logo.png"),
      ),
    );
  }
}
