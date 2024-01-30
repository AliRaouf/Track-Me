import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:track_me/blocs/nutrition/nutrition_cubit.dart';

class AddFoodDialog extends StatelessWidget {
  AddFoodDialog({super.key,required this.nameController,required this.descController});
  final TextEditingController nameController;
  final TextEditingController descController;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    int iron = 0;
    int fiber = 0;
    int protein = 0;
    int carbs = 0;
    int fat = 0;
    int calories = 0;
    return AlertDialog(
      title: const Text("Add Food"),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(" Name: "),
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                            constraints: BoxConstraints(
                                maxWidth:
                                screenWidth * 0.4,
                                maxHeight:
                                screenHeight * 0.04)),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(" Description: "),
                      TextField(
                        controller: descController,
                        decoration: InputDecoration(
                            constraints: BoxConstraints(
                                maxWidth: screenWidth * 0.4,
                                maxHeight:
                                screenHeight * 0.04)),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(" Calories: "),
                      TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          calories = int.parse(value);
                          print(calories);
                        },
                        decoration: InputDecoration(
                            constraints: BoxConstraints(
                                maxWidth:
                                screenWidth * 0.4,
                                maxHeight:
                                screenHeight * 0.04)),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(" Protein: "),
                      TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          protein = int.parse(value);
                          print(calories);
                        },
                        decoration: InputDecoration(
                            constraints: BoxConstraints(
                                maxWidth:
                                screenWidth * 0.4,
                                maxHeight:
                                screenHeight * 0.04)),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(" Carbs: "),
                      TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          carbs = int.parse(value);
                          print(carbs);
                        },
                        decoration: InputDecoration(
                            constraints: BoxConstraints(
                                maxWidth:
                                screenWidth * 0.4,
                                maxHeight:
                                screenHeight * 0.04)),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(" Fiber: "),
                      TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          fiber = int.parse(value);
                          print(fiber);
                        },
                        decoration: InputDecoration(
                            constraints: BoxConstraints(
                                maxWidth:
                                screenWidth * 0.4,
                                maxHeight:
                                screenHeight * 0.04)),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(" Fat: "),
                      TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          fat = int.parse(value);
                          print(fat);
                        },
                        decoration: InputDecoration(
                            constraints: BoxConstraints(
                                maxWidth:
                                screenWidth * 0.4,
                                maxHeight:
                                screenHeight * 0.04)),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(" Iron: "),
                      TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          iron = int.parse(value);
                          print(iron);
                        },
                        decoration: InputDecoration(
                            constraints: BoxConstraints(
                                maxWidth:
                                screenWidth * 0.4,
                                maxHeight:
                                screenHeight * 0.04)),
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
                        borderRadius:
                        BorderRadius.circular(20),
                        side:
                        const BorderSide(color: Colors.red))),
                backgroundColor: const MaterialStatePropertyAll(
                    Colors.white)),
            child: Text("Close",
                style: GoogleFonts.itim(color: Colors.red))),
        ElevatedButton(
            onPressed: () {
              NutritionCubit.get(context).saveFood(
                  nameController!.text,
                  calories,
                  descController!.text,
                  protein,
                  fiber,
                  fat,
                  carbs,
                  iron,
                  FieldValue.serverTimestamp());
              NutritionCubit.get(context).addToCurrentNutrition(calories, protein,
                  carbs, fiber, fat, iron);
              Navigator.of(context).pop();
            },
            style: const ButtonStyle(
                backgroundColor:
                MaterialStatePropertyAll(Colors.red)),
            child: Text(
              "Add",
              style: GoogleFonts.itim(color: Colors.white),
            ))
      ],
    );
  }
}
