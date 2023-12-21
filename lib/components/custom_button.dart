import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    required this.screenWidth,
    required this.screenHeight, required this.text, required this.onpressed, required this.bColor,this.sColor, required this.tColor
  });

  final double screenWidth;
  final double screenHeight;
  final String text;
  final Function() onpressed;
  final Color bColor;
  final Color tColor;
  Color? sColor;



  @override
  Widget build(BuildContext context) {
    return Container(width: screenWidth,height: screenHeight,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
      ),
      child: ElevatedButton(
        style: ButtonStyle(side: MaterialStatePropertyAll(BorderSide(color: sColor??Colors.transparent)),
            backgroundColor: MaterialStatePropertyAll(bColor),
            shadowColor: MaterialStatePropertyAll(Colors.transparent),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)))),
        onPressed:onpressed,
        child: Text(text,style: GoogleFonts.itim(color: tColor,fontSize: 13),),
      ),
    );
  }
}