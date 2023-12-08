import 'package:flutter/material.dart';
import 'package:track_me/screen/register_screen.dart';

import '../components/gradient_button.dart';
import 'login_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Container(child: Image.asset("assets/images/logo.png")),
          GradientButton(
            screenWidth: screenWidth * 0.74,
            screenHeight: screenHeight * 0.075,
            text: 'Login',
            onpressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          ),
          Container(
              margin: EdgeInsets.symmetric(vertical: screenHeight * 0.05),
              child: GradientButton(
                screenWidth: screenWidth * 0.74,
                screenHeight: screenHeight * 0.075,
                text: 'Register',
                onpressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()));
                },
              )),
          GradientButton(
            screenWidth: screenWidth * 0.74,
            screenHeight: screenHeight * 0.075,
            text: 'Continue as a Guest',
            onpressed: () {},
          )
        ]),
      ),
    );
  }
}
