import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../blocs/nutrition/nutrition_cubit.dart';

class NutritionContainer extends StatelessWidget {
  NutritionContainer({
    super.key,
    required this.widget,
    required this.text,
    required this.remaining,
    required this.color,
    required this.percent,
  });

  final Widget widget;
  final String text;
  final String remaining;
  final Color color;
  var nutritionController = TextEditingController();
  final double percent;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(
                    "Set your $text goal",
                    style: GoogleFonts.itim(),
                  ),
                  content: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // Align content to the left
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text("Amount: "),
                                  TextField(
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: false),
                                    controller: nutritionController,
                                    decoration: InputDecoration(
                                        constraints: BoxConstraints(
                                            maxWidth: screenWidth * 0.4,
                                            maxHeight: screenHeight * 0.04)),
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
                        style: ButtonStyle(
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: const BorderSide(color: Colors.red))),
                            backgroundColor:
                                const MaterialStatePropertyAll(Colors.white)),
                        child: Text("Close",
                            style: GoogleFonts.itim(color: Colors.red))),
                    ElevatedButton(
                        onPressed: () async {
                         await NutritionCubit.get(context).updateNutritionData(
                              {text: int.parse(nutritionController.text)});
                         await NutritionCubit.get(context).receiveNutrition();
                          Navigator.of(context).pop();
                        },
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.red)),
                        child: Text(
                          "Update",
                          style: GoogleFonts.itim(color: Colors.white),
                        ))
                  ],
                );
              });
        }
      },
      child: Container(
          height: screenHeight * 0.1,
          width: screenWidth * 0.45,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    widget,
                    Text(
                      text,
                      style:
                          GoogleFonts.itim(color: Colors.white, fontSize: 16),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(remaining,
                        style: GoogleFonts.itim(
                            color: Colors.white, fontSize: 12)),
                  ],
                ),
                LinearPercentIndicator(
                  barRadius: const Radius.circular(8),
                  width: MediaQuery.of(context).size.width * 0.38333,
                  lineHeight: 8.0,
                  percent: percent,
                  progressColor: Colors.white,
                ),
              ],
            ),
          )),
    );
  }
}
