
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track_me/blocs/user/user_cubit.dart';
import 'package:track_me/components/custom_form_text_field.dart';
import '../components/gradient_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  bool _isPasswordObscured = true;
  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordObscured = !_isPasswordObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var cubit = UserCubit.get(context);
    TextEditingController passwordController = TextEditingController(text: cubit.password??"");
    TextEditingController userNameController = TextEditingController(text: cubit.userName??"");
    TextEditingController emailController = TextEditingController(text: cubit.user?.email??"");
    TextEditingController GenderController = TextEditingController(text: cubit.gender??"");
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xfffafafa),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView(children: [
              Stack(
                children: [
                  Center(
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: screenHeight * 0.05),
                        child: CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(cubit.imageUrl),
                          backgroundColor: Colors.white,
                          onBackgroundImageError:(exception, stackTrace) {
                            setState(() {
                              cubit.imageUrl = 'https://static.vecteezy.com/system/resources/previews/009/292/244/original/default-avatar-icon-of-social-media-user-vector.jpg';
                            });
                          },
                        )
                      )),
                  Positioned(
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.add_a_photo_outlined)),
                      bottom: screenHeight * 0.03,
                      left: screenWidth * 0.55),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: screenWidth * 0.8,
                    margin: EdgeInsets.only(bottom: screenHeight * 0.05),
                    child: CustomTextFormField(
                      controller: userNameController,
                      hint: "UserName",
                      label: "UserName",
                      obscureText: false, readOnly: true,
                    ),
                  ),
                  Container(
                    width: screenWidth * 0.8,
                    margin: EdgeInsets.only(bottom: screenHeight * 0.05),
                    child: CustomTextFormField(
                      controller: emailController,
                      hint: "Email",
                      label: "Email",
                      obscureText: false, readOnly: true,
                    ),
                  ),
                  Container(
                    width: screenWidth * 0.8,
                    margin: EdgeInsets.only(bottom: screenHeight * 0.05),
                    child: CustomTextFormField(
                     controller: passwordController,
                      hint: "Password",
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
                      iconColor:
                      _isPasswordObscured ? Colors.blue : Colors.grey, readOnly: true,
                    ),
                  ), Container(
                    width: screenWidth * 0.8,
                    margin: EdgeInsets.only(bottom: screenHeight * 0.05),
                    child: CustomTextFormField(
                      controller: GenderController,
                      hint: "Gender",
                      label: "Gender",
                      obscureText: false, readOnly: true,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: screenHeight * 0.1),
                    child: GradientButton(
                      screenWidth: screenWidth * 0.38,
                      screenHeight: screenHeight * 0.075,
                      text: 'Back',
                      onpressed: () {
                        Navigator.pop(context);
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
