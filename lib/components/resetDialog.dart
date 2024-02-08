import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:track_me/blocs/water/water_cubit.dart';

import 'custom_button.dart';

class ResetDialog extends StatefulWidget {
  const ResetDialog({super.key});

  @override
  State<ResetDialog> createState() => _ResetDialogState();
}

class _ResetDialogState extends State<ResetDialog> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return AlertDialog(
      title: Text(
        "Do you want to Reset your Water Counter?",
        style: GoogleFonts.itim(),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [],
              ),
            ),
          ],
        ),
      ),
      contentPadding: EdgeInsets.zero,
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        CustomButton(
            borderColor: Colors.blueAccent,
            screenWidth: screenWidth * 0.25,
            screenHeight: screenHeight * 0.05,
            text: "No",
            onpressed: () {
              Navigator.pop(context);
            },
            bColor: Colors.white,
            tColor: Colors.blueAccent,
            fontSize: 18),
        CustomButton(
            borderColor: Colors.white,
            screenWidth: screenWidth * 0.25,
            screenHeight: screenHeight * 0.05,
            text: "Yes",
            onpressed: () async {
              await WaterCubit.get(context)
                  .updateWaterData({"goal": 0, "currentWater": 0});
              await WaterCubit.get(context).receiveWater();
              setState(() {});
              Navigator.pop(context);
            },
            bColor: Colors.blueAccent,
            tColor: Colors.white,
            fontSize: 18)
      ],
    );
  }
}
