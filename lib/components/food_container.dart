import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodContainer extends StatelessWidget {
  const FoodContainer({
    super.key,
    required this.Height,
    this.Width,
    this.title,
    this.calories,
    this.protein,
    this.carbs,
    required this.ontap,
  });

  final double Height;
  final double? Width;
  final String? title;
  final double? calories;
  final double? protein;
  final double? carbs;
  final Function() ontap;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: Height,
        width: Width,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
            color: const Color(0xffFFD37E),
            borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      "$title",
                      style: GoogleFonts.itim(
                          fontSize: 16,
                          color: const Color(0xff252525),
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: screenWidth * 0.255,
                    child: Text("Cal:$calories",
                        style: GoogleFonts.itim(
                            fontSize: 12, color: const Color(0xff252525))),
                  ),
                  SizedBox(
                    width: screenWidth * 0.26,
                    child: Text("Prot:$protein",
                        style: GoogleFonts.itim(
                            fontSize: 12, color: const Color(0xff252525))),
                  ),
                  SizedBox(
                    width: screenWidth * 0.26,
                    child: Text("Carb:$carbs",
                        style: GoogleFonts.itim(
                            fontSize: 12, color: const Color(0xff252525))),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
