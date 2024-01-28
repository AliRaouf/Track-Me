import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatelessWidget {
  String? hint;
  String? label;
  TextEditingController? controller;
  bool? obscureText;
  IconButton? icon;
  Color? iconColor;
  String? Function(String?)? validate;
  bool readOnly;
  void Function(String)? onchange;

  CustomTextFormField(
      {super.key,required this.readOnly,
      required this.hint, this.controller,
      required this.label,
      required this.obscureText,
      this.icon,
      this.iconColor,
      this.validate,
      this.onchange});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged:onchange ,
      readOnly: readOnly,
      autovalidateMode:AutovalidateMode.onUserInteraction,
      controller: controller,
      obscureText: obscureText!,
      validator:validate ,
      decoration: InputDecoration(contentPadding: const EdgeInsets.symmetric(vertical:15,horizontal: 15),
          hintText: hint,
          labelText: label,
          labelStyle: GoogleFonts.itim(fontSize: 18,color: const Color(0xff00a5fa)),
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
          borderSide: const BorderSide(color: Colors.black)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.black))
      ),
    );
  }
}
