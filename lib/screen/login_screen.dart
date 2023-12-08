import 'package:flutter/material.dart';
import 'package:track_me/components/custom_form_text_field.dart';

import '../components/gradient_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordObscured = true;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordObscured = !_isPasswordObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xfffafafa),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView(children: [Stack(
          children: [
              Center(
                child: Container(
                    child: Image.asset(
                  "assets/images/logo.png",
                )
                ),
              ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios_new_outlined)),
              ],
            ),
          ],
        ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: screenWidth * 0.8,
                height: screenHeight * 0.09,
                margin: EdgeInsets.only(
                    bottom: screenHeight * 0.04),
                child: CustomTextFormField(
                  hint: "Email",
                  controller: emailController,
                  label: "Email",
                  obscureText: false,
                ),
              ),
              Container(
                width: screenWidth * 0.8,
                height: screenHeight * 0.09,
                margin: EdgeInsets.only(
                    bottom: screenHeight * 0.06),
                child: CustomTextFormField(
                  hint: "Password",
                  controller: passwordController,
                  label: "Password",
                  obscureText: _isPasswordObscured,
                  icon: IconButton(
                      onPressed: () {
                        setState(() {
                          _togglePasswordVisibility();
                        });
                      },
                      icon: Icon(_isPasswordObscured
                          ? Icons.visibility
                          : Icons.visibility_off)),
                  iconColor: _isPasswordObscured ? Colors.blue : Colors.grey,
                ),
              ),
              GradientButton(
                screenWidth: screenWidth * 0.38,
                screenHeight: screenHeight * 0.075,
                text: 'Login',
                onpressed: () {},
              ),
            ],
          )
        ]),
      ),
    );
  }
}
