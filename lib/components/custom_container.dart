import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    this.color, required this.text,this.widget,this.gradient, this.image, required this.onTap,

  });

  final double screenWidth;
  final double screenHeight;
  final Color? color;
  final String text;
  final Widget? widget;
  final Gradient? gradient;
  final DecorationImage? image;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onTap ,
      child: Container(margin: EdgeInsets.only(top: screenHeight*0.2),
        width: screenWidth,
        height: screenHeight,
        decoration: BoxDecoration(gradient: gradient,image: image,
            borderRadius: BorderRadius.circular(10),
            color: color),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(alignment: Alignment.topLeft,
                child: Text(
                  text,
                  style: GoogleFonts.itim(fontSize: 17, color: const Color(0xfffafafa)),
                ),
              ),
              widget??const SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}