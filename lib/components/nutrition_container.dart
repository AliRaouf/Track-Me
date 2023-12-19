import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../blocs/nutrition/nutrition_cubit.dart';

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
  var nutritionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: (){ {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Set your$text goal",style: GoogleFonts.itim(),),
              content: SingleChildScrollView(
                child: Column(mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // Align content to the left
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Amount: "),
                              TextField(
                                controller: nutritionController,
                                decoration: InputDecoration(
                                    constraints: BoxConstraints(
                                        maxWidth: screenWidth * 0.5,
                                        maxHeight:
                                        screenHeight * 0.05)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              contentPadding: EdgeInsets.zero,
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Close",
                        style: GoogleFonts.itim(color: Colors.red)),
                    style: ButtonStyle(
                        shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(20),
                                side: BorderSide(color: Colors.red))),
                        backgroundColor:
                        MaterialStatePropertyAll(Colors.white))),
                ElevatedButton(
                    onPressed: () {
                      NutritionCubit.get(context).updateNutritionData(
                          {text:nutritionController.text});
                    },
                    child: Text(
                      "Update",
                      style: GoogleFonts.itim(color: Colors.white),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStatePropertyAll(Colors.red)))
              ],
            );
          });
    }
    },
      child: Container(height: screenHeight,width: screenWidth,
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
          )),
    );
  }
}