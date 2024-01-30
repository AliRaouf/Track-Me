import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,this.type,
      required this.controller,
      this.iconButton,
      this.hint,
      this.icon,
      this.iconColor,
      this.label,
      required this.obscureText,
      required this.readOnly});

  final TextEditingController controller;
  Icon? icon;
  String? hint;
  String? label;
  IconButton? iconButton;
  bool obscureText;
  bool readOnly;
  Color? iconColor;
  TextInputType? type;
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType:type,
        readOnly: readOnly,
        obscureText: obscureText,
        controller: controller,
        decoration: InputDecoration(
          prefixIconColor:const Color(0xff00a5fa),
          prefixIcon: icon,
          labelText: label,
          labelStyle: GoogleFonts.itim(fontSize: 18, color: const Color(0xff00a5fa)),
          hintText: hint,
          hintStyle: GoogleFonts.itim(fontSize: 18),
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          suffixIcon: iconButton,
          suffixIconColor: iconColor,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey)),
        ));
  }
}
