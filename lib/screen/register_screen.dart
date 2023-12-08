import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track_me/blocs/register/register_cubit.dart';
import 'package:track_me/components/custom_form_text_field.dart';

import '../components/gradient_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isPasswordObscured = true;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var usernameController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var genderController = TextEditingController();
  List<DropdownMenuEntry<String>> genders = [
  const DropdownMenuEntry(value: "Male", label: "Male"),
  const DropdownMenuEntry(value: "Female", label: "Female"),
];

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordObscured = !_isPasswordObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var cubit=RegisterCubit.get(context);
    return BlocConsumer<RegisterCubit, RegisterState>(
  listener: (context, state) {
    if(state is RegisterSuccessState){
      cubit.showSnackBar(context, "Account Created Successfully");
    }else if(state is RegisterErrorState){
      cubit.showSnackBar(context, state.error.toString());
    }
  },
  builder: (context, state) {
    return Scaffold(
      backgroundColor: const Color(0xfffafafa),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView(children: [Stack(
          children: [
              Center(
                child: SizedBox(height: screenHeight*0.3,
                    child: Image.asset(
                      "assets/images/logo.png",
                    )
                ),
              ), Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios_new_outlined)),
              ],
            )
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
                  hint: "UserName",
                  controller: usernameController,
                  label: "UserName",
                  obscureText: false,
                ),
              ),
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
                    bottom: screenHeight * 0.04),
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
              DropdownMenu<String>(
                  width: screenWidth * 0.8,
                  inputDecorationTheme: InputDecorationTheme(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                          const BorderSide(color: Colors.black)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                          const BorderSide(color: Colors.black))),
                  label: const Text(
                    "Gender",
                    style: TextStyle(fontSize: 24),
                  ),
                  controller: genderController,
                  dropdownMenuEntries: genders,
                  onSelected: (value) {
                    genderController.text = value!;
                    print(genderController.text);
                  }),
              Container(margin: EdgeInsets.only(top: screenHeight*0.05),
                child: GradientButton(
                  screenWidth: screenWidth * 0.38,
                  screenHeight: screenHeight * 0.075,
                  text: 'Register',
                  onpressed: () {
                    print("${emailController.text},${passwordController.text}, ${usernameController
                        .text}, ${genderController.text}");
                    cubit.registerUser(emailController.text, passwordController.text, usernameController.text, genderController.text);
                  },
                ),
              ),
            ],
          )
        ]),
      ),
    );
  },
);
  }
}
