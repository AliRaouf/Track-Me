import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:track_me/blocs/nutrition/nutrition_cubit.dart';
import 'package:track_me/components/gradient_text.dart';
import 'package:track_me/components/nutrition_container.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:track_me/components/nutrition_food_list.dart';

class NutritionScreen extends StatefulWidget {
  const NutritionScreen({super.key});

  @override
  State<NutritionScreen> createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  @override
  void initState() {
    NutritionCubit.get(context).getUserData();
    NutritionCubit.get(context).createNutritionDataSet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = NutritionCubit.get(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var nameController = TextEditingController();
    var descController = TextEditingController();
    var caloriesController = TextEditingController();
    var proteinController = TextEditingController();
    var carbController = TextEditingController();
    var fiberController = TextEditingController();
    var fatController = TextEditingController();
    var ironController = TextEditingController();
    String pIcon =
        '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="#fafafa" d="M9 7v10h2v-4h2a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2zm2 2h2v2h-2zm1-7a10 10 0 0 1 10 10a10 10 0 0 1-10 10A10 10 0 0 1 2 12A10 10 0 0 1 12 2"/></svg>';
    String cIcon =
        '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="#fafafa" d="M12 2a10 10 0 0 1 10 10a10 10 0 0 1-10 10A10 10 0 0 1 2 12A10 10 0 0 1 12 2m-1 5a2 2 0 0 0-2 2v6a2 2 0 0 0 2 2h2a2 2 0 0 0 2-2v-1h-2v1h-2V9h2v1h2V9a2 2 0 0 0-2-2z"/></svg>';
    String leafIcon =
        '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="#fafafa" d="M17 8C8 10 5.9 16.17 3.82 21.34l1.89.66l.95-2.3c.48.17.98.3 1.34.3C19 20 22 3 22 3c-1 2-8 2.25-13 3.25S2 11.5 2 13.5s1.75 3.75 1.75 3.75C7 8 17 8 17 8"/></svg>';
    String fIcon =
        '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="#fafafa" d="M12 2a10 10 0 0 1 10 10a10 10 0 0 1-10 10A10 10 0 0 1 2 12A10 10 0 0 1 12 2M9 7v10h2v-4h3v-2h-3V9h4V7z"/></svg>';
    String ironIcon =
        '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="#fafafa" d="M20.57 14.86L22 13.43L20.57 12L17 15.57L8.43 7L12 3.43L10.57 2L9.14 3.43L7.71 2L5.57 4.14L4.14 2.71L2.71 4.14l1.43 1.43L2 7.71l1.43 1.43L2 10.57L3.43 12L7 8.43L15.57 17L12 20.57L13.43 22l1.43-1.43L16.29 22l2.14-2.14l1.43 1.43l1.43-1.43l-1.43-1.43L22 16.29z"/></svg>';
    return BlocConsumer<NutritionCubit, NutritionState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
            floatingActionButton: FloatingActionButton(
              shape: CircleBorder(),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Add Food"),
                        content: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // Align content to the left
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Name: "),
                                        TextField(
                                          controller: nameController,
                                          decoration: InputDecoration(
                                              constraints: BoxConstraints(
                                                  maxWidth: screenWidth * 0.5,
                                                  maxHeight:
                                                      screenHeight * 0.05)),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Description: "),
                                        TextField(
                                          controller: descController,
                                          decoration: InputDecoration(
                                              constraints: BoxConstraints(
                                                  maxWidth: screenWidth * 0.5,
                                                  maxHeight:
                                                      screenHeight * 0.05)),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Calories: "),
                                        TextField(
                                          controller: caloriesController,
                                          decoration: InputDecoration(
                                              constraints: BoxConstraints(
                                                  maxWidth: screenWidth * 0.5,
                                                  maxHeight:
                                                      screenHeight * 0.05)),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Protein: "),
                                        TextField(
                                          controller: proteinController,
                                          decoration: InputDecoration(
                                              constraints: BoxConstraints(
                                                  maxWidth: screenWidth * 0.5,
                                                  maxHeight:
                                                      screenHeight * 0.05)),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Carbs: "),
                                        TextField(
                                          controller: carbController,
                                          decoration: InputDecoration(
                                              constraints: BoxConstraints(
                                                  maxWidth: screenWidth * 0.5,
                                                  maxHeight:
                                                      screenHeight * 0.05)),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Fiber: "),
                                        TextField(
                                          controller: fiberController,
                                          decoration: InputDecoration(
                                              constraints: BoxConstraints(
                                                  maxWidth: screenWidth * 0.5,
                                                  maxHeight:
                                                      screenHeight * 0.05)),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Fat: "),
                                        TextField(
                                          controller: fatController,
                                          decoration: InputDecoration(
                                              constraints: BoxConstraints(
                                                  maxWidth: screenWidth * 0.5,
                                                  maxHeight:
                                                      screenHeight * 0.05)),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Iron: "),
                                        TextField(
                                          controller: ironController,
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
                                cubit.saveFood(
                                    nameController.text,
                                    caloriesController.text,
                                    descController.text,
                                    proteinController.text,
                                    fiberController.text,
                                    fatController.text,
                                    carbController.text,
                                    ironController.text,
                                    FieldValue.serverTimestamp());
                              },
                              child: Text(
                                "Add",
                                style: GoogleFonts.itim(color: Colors.white),
                              ),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.red)))
                        ],
                      );
                    });
              },
              mini: true,
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    gradient: LinearGradient(
                      colors: [Color(0xffCDBF4C), Color(0xff535707)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  width: 200,
                  height: 200,
                  child: Icon(
                    Icons.add,
                    size: 32,
                    color: Colors.white,
                  )),
            ),
            backgroundColor: Color(0xfffafafa),
            appBar: AppBar(
              backgroundColor: Color(0xfffafafa),
              centerTitle: true,
              leading: IconButton(
                  color: Color(0xff535707),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_outlined)),
              title: GradientText(
                "Nutrition",
                gradient: LinearGradient(
                  colors: [Color(0xffCDBF4C), Color(0xff535707)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                style: GoogleFonts.itim(color: Color(0xffFF8000), fontSize: 32),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NutritionContainer(
                      screenHeight: screenHeight * 0.1,
                      screenWidth: screenWidth * 0.45,
                      widget: Icon(
                        CupertinoIcons.flame_fill,
                        size: 14,
                        color: Colors.white,
                      ),
                      text: 'calories',
                      remaining: '0 Remaining',
                      color: Colors.red,
                    ),
                    NutritionContainer(
                        screenHeight: screenHeight * 0.1,
                        screenWidth: screenWidth * 0.45,
                        widget: Iconify(
                          pIcon,
                          color: Colors.white,
                          size: 16,
                        ),
                        text: " Protein",
                        remaining: "0 Remaining",
                        color: Colors.orange),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NutritionContainer(
                          screenHeight: screenHeight * 0.1,
                          screenWidth: screenWidth * 0.45,
                          widget: Iconify(
                            cIcon,
                            color: Colors.white,
                            size: 16,
                          ),
                          text: " Carbohydrates",
                          remaining: "0 Remaining",
                          color: Colors.blueAccent),
                      NutritionContainer(
                          screenHeight: screenHeight * 0.1,
                          screenWidth: screenWidth * 0.45,
                          widget: Iconify(
                            leafIcon,
                            color: Colors.white,
                            size: 16,
                          ),
                          text: " Fiber",
                          remaining: "0 Remaining",
                          color: Colors.green),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NutritionContainer(
                        screenHeight: screenHeight * 0.1,
                        screenWidth: screenWidth * 0.45,
                        widget: Iconify(
                          fIcon,
                          color: Colors.white,
                          size: 16,
                        ),
                        text: " Fat",
                        remaining: "0 Remaining",
                        color: Color(0xff33a3b2)),
                    NutritionContainer(
                        screenHeight: screenHeight * 0.1,
                        screenWidth: screenWidth * 0.45,
                        widget: Iconify(
                          ironIcon,
                          color: Colors.white,
                          size: 16,
                        ),
                        text: " Iron",
                        remaining: "0 Remaining",
                        color: Color(0xff7da1c3)),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "  Food",
                      style: GoogleFonts.itim(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Color(0xff535707)),
                    ),
                  ],
                ),
                NutritionFoodList(foodStream: cubit.foodStream!)
              ]),
            ));
      },
    );
  }
}
