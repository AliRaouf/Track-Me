import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

class NutritionContainer extends StatelessWidget {
  NutritionContainer({
    super.key,
    required this.screenHeight,
    required this.screenWidth,required this.widget, required this.text, required this.remaining, required this.color,
  });

  final double screenHeight;
  final double screenWidth;
  final Widget widget;
  final String text;
  final String remaining;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(height: screenHeight,width: screenWidth,
        decoration:BoxDecoration(color: color,borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 4),
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(children: [
                widget,
                Text(text,style: GoogleFonts.itim(color: Colors.white,fontSize: 16),)
              ],),
              Row(
                children: [
                  Text(remaining,style: GoogleFonts.itim(color: Colors.white,fontSize: 12)),
                ],
              ),
              LinearPercentIndicator(barRadius: Radius.circular(8),
                width: MediaQuery.of(context).size.width*0.38333,
                lineHeight: 8.0,
                percent: 0.2,
                progressColor: Colors.white,
              ),
            ],
          ),
        ));
  }
}