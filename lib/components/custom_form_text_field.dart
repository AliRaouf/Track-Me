import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatelessWidget {
  String? hint;
  String? label;
  TextEditingController? controller;
  bool? obscureText;
  IconButton? icon;
  Color? iconColor;

  CustomTextFormField(
      {super.key,
      required this.hint,
      required this.controller,
      required this.label,
      required this.obscureText,
      this.icon,
      this.iconColor});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode:AutovalidateMode.onUserInteraction,
      controller: controller,
      obscureText: obscureText!,
      validator: (data) {
        if (data!.isEmpty) {
          return "field is required";
        }
      },
      decoration: InputDecoration(
          hintText: hint,
          labelText: label,
          labelStyle: GoogleFonts.itim(fontSize: 18),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.black)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.black)),
          suffixIcon:icon,
          suffixIconColor:iconColor
      ,focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.black))
      ),
    );
  }
}
