import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:track_me/components/custom_form_text_field.dart';
import 'package:track_me/screen/login_screen.dart';
import '../blocs/user/user_cubit.dart';
import '../components/gradient_button.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  var oldPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmNewPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var cubit = UserCubit.get(context);
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is ChangeUserPasswordSuccessState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginScreen()));
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Password Changed Successfully")));
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xfffafafa),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView(children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios_new_outlined)),
                ],
              ),
              Container(
                  margin: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.04, horizontal: 16),
                  child: Text(
                    "Want to Change your Password?",
                    style: GoogleFonts.itim(fontSize: 18),
                  )),
              Column(
                children: [
                  Container(
                    width: screenWidth * 0.8,
                    margin: EdgeInsets.only(bottom: screenHeight * 0.05),
                    child: CustomTextFormField(
                      hint: "Old Password",
                      controller: oldPasswordController,
                      label: "Old Password",
                      obscureText: cubit.isOldPasswordObscured,
                      icon: IconButton(
                          onPressed: () {
                            setState(() {
                              cubit.toggleOldPasswordVisibility();
                            });
                          },
                          icon: Icon(cubit.isOldPasswordObscured
                              ? Icons.visibility
                              : Icons.visibility_off)),
                      iconColor: cubit.isOldPasswordObscured
                          ? Colors.blue
                          : Colors.grey,
                      readOnly: false,
                    ),
                  ),
                  Container(
                    width: screenWidth * 0.8,
                    margin: EdgeInsets.only(bottom: screenHeight * 0.05),
                    child: CustomTextFormField(
                      hint: "New Password",
                      controller: newPasswordController,
                      label: "New Password",
                      obscureText: cubit.isNewPasswordObscured,
                      icon: IconButton(
                          onPressed: () {
                            setState(() {
                              cubit.toggleNewPasswordVisibility();
                            });
                          },
                          icon: Icon(cubit.isNewPasswordObscured
                              ? Icons.visibility
                              : Icons.visibility_off)),
                      iconColor: cubit.isNewPasswordObscured
                          ? Colors.blue
                          : Colors.grey,
                      readOnly: false,
                    ),
                  ),
                  Container(
                    width: screenWidth * 0.8,
                    margin: EdgeInsets.only(bottom: screenHeight * 0.05),
                    child: CustomTextFormField(
                      validate: (data) {
                        if (confirmNewPasswordController.text !=
                            newPasswordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      hint: "Confirm New Password",
                      controller: confirmNewPasswordController,
                      label: "Confirm New Password",
                      obscureText: cubit.isConfirmNewPasswordObscured,
                      icon: IconButton(
                          onPressed: () {
                            setState(() {
                              cubit.toggleConfirmNewPasswordVisibility();
                            });
                          },
                          icon: Icon(cubit.isConfirmNewPasswordObscured
                              ? Icons.visibility
                              : Icons.visibility_off)),
                      iconColor: cubit.isConfirmNewPasswordObscured
                          ? Colors.blue
                          : Colors.grey,
                      readOnly: false,
                    ),
                  ),
                  GradientButton(
                    screenWidth: screenWidth * 0.6,
                    screenHeight: screenHeight * 0.075,
                    text: 'Change Password',
                    onpressed: () {
                      cubit.changeUserPassword(oldPasswordController.text,
                          newPasswordController.text);
                    },
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
