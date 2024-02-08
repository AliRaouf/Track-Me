import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExerciseDropDown extends StatefulWidget {
  final TextEditingController controller;

  const ExerciseDropDown({Key? key, required this.controller})
      : super(key: key);

  @override
  State<ExerciseDropDown> createState() => _ExerciseDropDownState();
}

class _ExerciseDropDownState extends State<ExerciseDropDown> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    List<DropdownMenuEntry<String>> exercises = [
      const DropdownMenuEntry(value: "back", label: "Back"),
      const DropdownMenuEntry(value: "cardio", label: "Cardio"),
      const DropdownMenuEntry(value: "chest", label: "Chest"),
      const DropdownMenuEntry(value: "lower arms", label: "Lower Arms"),
      const DropdownMenuEntry(value: "lower legs", label: "Lower Legs"),
      const DropdownMenuEntry(value: "neck", label: "Neck"),
      const DropdownMenuEntry(value: "shoulders", label: "Shoulders"),
      const DropdownMenuEntry(value: "upper arms", label: "Upper Arms"),
      const DropdownMenuEntry(value: "upper legs", label: "Upper Legs"),
      const DropdownMenuEntry(value: "waist", label: "Waist"),
    ];
    return DropdownMenu<String>(
      menuStyle: MenuStyle(
          shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
          maximumSize: MaterialStatePropertyAll(
              Size(screenWidth * 0.7, screenHeight * 0.25))),
      width: screenWidth * 0.6,
      inputDecorationTheme: InputDecorationTheme(
          constraints: BoxConstraints(maxHeight: screenHeight * 0.075),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent)),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent))),
      label: Text(
        "Choose Exercise",
        style: GoogleFonts.itim(fontSize: 16),
      ),
      trailingIcon: const Icon(
        Icons.arrow_drop_down_sharp,
        color: Colors.purple,
      ),
      selectedTrailingIcon: const Icon(
        Icons.arrow_drop_up,
        color: Colors.purple,
      ),
      controller: widget.controller,
      textStyle: GoogleFonts.itim(color: const Color(0xff9932CC)),
      dropdownMenuEntries: exercises,
    );
  }
}
