import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track_me/blocs/login/login_cubit.dart';
import 'package:track_me/screen/register_screen.dart';

import '../components/gradient_button.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var cubit = LoginCubit.get(context);
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is GuestLoginSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Signed in with a temporary account")));
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        } else if (state is LoginErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error.toString())));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: screenHeight * 0.05),
                child: Image.asset("assets/images/logo.png"),
              ),
              GradientButton(
                screenWidth: screenWidth * 0.74,
                screenHeight: screenHeight * 0.075,
                text: 'Login',
                onpressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
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
                          MaterialPageRoute(
                              builder: (context) => const RegisterScreen()));
                    },
                  )),
              GradientButton(
                screenWidth: screenWidth * 0.74,
                screenHeight: screenHeight * 0.075,
                text: 'Continue as a Guest',
                onpressed: () {
                  cubit.guestLogin();
                },
              )
            ]),
          ),
        );
      },
    );
  }
}
