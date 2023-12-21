import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TargetDropDown extends StatefulWidget {
  final TextEditingController controller;
 TargetDropDown({Key? key, required this.controller}) : super(key: key);

  @override
  State<TargetDropDown> createState() => _TargetDropDownState();
}

class _TargetDropDownState extends State<TargetDropDown> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    List<DropdownMenuEntry<String>> targets = [
      const DropdownMenuEntry(value: "abductors", label: "Abductors"),
      const DropdownMenuEntry(value: "abs", label: "Abs"),
      const DropdownMenuEntry(value: "adductors", label: "Adductors"),
      const DropdownMenuEntry(value: "biceps", label: "Biceps"),
      const DropdownMenuEntry(value: "calves", label: "Calves"),
      const DropdownMenuEntry(value: "cardiovascular system", label: "Cardiovascular System"),
      const DropdownMenuEntry(value: "delts", label: "Delts"),
      const DropdownMenuEntry(value: "forearms", label: "Forearms"),
      const DropdownMenuEntry(value: "glutes", label: "Glutes"),
      const DropdownMenuEntry(value: "hamstrings", label: "Hamstrings"),
      const DropdownMenuEntry(value: "lats", label: "Lats"),
      const DropdownMenuEntry(value: "levator scapulae", label: "Levator Scapulae"),
      const DropdownMenuEntry(value: "pectorals", label: "Pectorals"),
      const DropdownMenuEntry(value: "quads", label: "Quads"),
      const DropdownMenuEntry(value: "serratus anterior", label: "Serratus Anterior"),
      const DropdownMenuEntry(value: "spine", label: "Spine"),
      const DropdownMenuEntry(value: "traps", label: "Traps"),
      const DropdownMenuEntry(value: "triceps", label: "Triceps"),
      const DropdownMenuEntry(value: "upper back", label: "Upper Back"),
      const DropdownMenuEntry(value: "hamstrings", label: "Hamstrings"),

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
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent)),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent))),
      label: Text(
        "Choose Target",
        style: GoogleFonts.itim(fontSize: 16),
      ),trailingIcon:Icon(Icons.arrow_drop_down_sharp,color: Colors.purple,),
      selectedTrailingIcon:Icon(Icons.arrow_drop_up,color: Colors.purple,),
      controller: widget.controller,
      textStyle: GoogleFonts.itim(color: Color(0xff9932CC)),
      dropdownMenuEntries: targets,
    );
  }
}
