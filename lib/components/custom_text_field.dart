import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../blocs/food/food_cubit.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller, this.onPressed, this.color,
  });

  final TextEditingController controller;
  final Function()? onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: "Search Here!",
          hintStyle: GoogleFonts.itim(fontSize: 18),
          contentPadding: EdgeInsets.symmetric(horizontal: 8),
          suffixIcon: IconButton(
              onPressed: onPressed,
              icon: Icon(Icons.search),
              color: color),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey)),
        ));
  }
}