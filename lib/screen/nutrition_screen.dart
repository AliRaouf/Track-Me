import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:track_me/blocs/nutrition/nutrition_cubit.dart';
import 'package:track_me/components/add_food_dialog.dart';
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
    NutritionCubit.get(context).receiveNutrition();
    NutritionCubit.get(context).receiveFoodList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = NutritionCubit.get(context);
    var nameController = TextEditingController();
    var descController = TextEditingController();
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
        if (state is UpdateNutritionSuccess) {
          setState(() {
            cubit.receiveNutrition();
            cubit.receiveFoodList();
          });
        }
        if (state is AddToCurrentNutritionSuccess) {
          setState(() {
            cubit.receiveNutrition();
            cubit.receiveFoodList();
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
            floatingActionButton: FloatingActionButton(
              shape: const CircleBorder(),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AddFoodDialog(
                        descController: descController,
                        nameController: nameController,
                      );
                    });
              },
              mini: true,
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    gradient: const LinearGradient(
                      colors: [Color(0xffCDBF4C), Color(0xff535707)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  width: 200,
                  height: 200,
                  child: const Icon(
                    Icons.add,
                    size: 32,
                    color: Colors.white,
                  )),
            ),
            backgroundColor: const Color(0xfffafafa),
            appBar: AppBar(
              forceMaterialTransparency: true,
              backgroundColor: const Color(0xfffafafa),
              centerTitle: true,
              leading: IconButton(
                  color: const Color(0xff535707),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_outlined)),
              title: GradientText(
                "Nutrition",
                gradient: const LinearGradient(
                  colors: [Color(0xffCDBF4C), Color(0xff535707)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                style: GoogleFonts.itim(
                    color: const Color(0xffFF8000), fontSize: 32),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NutritionContainer(
                      widget: const Icon(
                        CupertinoIcons.flame_fill,
                        size: 14,
                        color: Colors.white,
                      ),
                      text: 'calories',
                      remaining: () {
                        if (cubit.calories == 0) {
                          return "Add your Target Now !";
                        } else if (cubit.calories - cubit.currentCalories <=
                            0) {
                          return "Congrats You Finished it !";
                        } else {
                          return "${cubit.calories - cubit.currentCalories} Remaining";
                        }
                      }(),
                      color: Colors.red,
                      percent: (cubit.currentCalories.toInt() / cubit.calories)
                                  .isNaN ||
                              (cubit.currentCalories.toInt() / cubit.calories)
                                  .isNegative ||
                              (cubit.currentCalories.toInt() / cubit.calories)
                                  .isInfinite ||
                              (cubit.currentCalories.toInt() / cubit.calories) >
                                  1
                          ? 0
                          : (cubit.currentCalories.toInt() / cubit.calories),
                    ),
                    NutritionContainer(
                      widget: Iconify(
                        pIcon,
                        color: Colors.white,
                        size: 16,
                      ),
                      text: "protein",
                      remaining: () {
                        if (cubit.protein == 0) {
                          return "Add your Target Now !";
                        } else if (cubit.protein - cubit.currentProtein <= 0) {
                          return "Congrats You Finished it !";
                        } else {
                          return "${cubit.protein - cubit.currentProtein} Remaining";
                        }
                      }(),
                      color: Colors.orange,
                      percent: (cubit.currentProtein.toInt() / cubit.protein)
                                  .isNaN ||
                              (cubit.currentProtein.toInt() / cubit.protein)
                                  .isNegative ||
                              (cubit.currentProtein.toInt() / cubit.protein)
                                  .isInfinite ||
                              (cubit.currentProtein.toInt() / cubit.protein) > 1
                          ? 0
                          : (cubit.currentProtein.toInt() / cubit.protein),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NutritionContainer(
                        widget: Iconify(
                          cIcon,
                          color: Colors.white,
                          size: 16,
                        ),
                        text: "carbohydrates",
                        remaining: () {
                          if (cubit.carbs == 0) {
                            return "Add your Target Now !";
                          } else if (cubit.carbs - cubit.currentCarbs <= 0) {
                            return "Congrats You Finished it !";
                          } else {
                            return "${cubit.carbs - cubit.currentCarbs} Remaining";
                          }
                        }(),
                        color: Colors.blueAccent,
                        percent: (cubit.currentCarbs.toInt() / cubit.carbs)
                                    .isNaN ||
                                (cubit.currentCarbs.toInt() / cubit.carbs)
                                    .isNegative ||
                                (cubit.currentCarbs.toInt() / cubit.carbs)
                                    .isInfinite ||
                                (cubit.currentCarbs.toInt() / cubit.carbs) > 1
                            ? 0
                            : (cubit.currentCarbs.toInt() / cubit.carbs),
                      ),
                      NutritionContainer(
                        widget: Iconify(
                          leafIcon,
                          color: Colors.white,
                          size: 16,
                        ),
                        text: "fiber",
                        remaining: () {
                          if (cubit.fiber == 0) {
                            return "Add your Target Now !";
                          } else if (cubit.fiber - cubit.currentFiber <= 0) {
                            return "Congrats You Finished it !";
                          } else {
                            return "${cubit.fiber - cubit.currentFiber} Remaining";
                          }
                        }(),
                        color: Colors.green,
                        percent: (cubit.currentFiber.toInt() / cubit.fiber)
                                    .isNaN ||
                                (cubit.currentFiber.toInt() / cubit.fiber)
                                    .isNegative ||
                                (cubit.currentFiber.toInt() / cubit.fiber)
                                    .isInfinite ||
                                (cubit.currentFiber.toInt() / cubit.fiber) > 1
                            ? 0
                            : (cubit.currentFiber.toInt() / cubit.fiber),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NutritionContainer(
                      widget: Iconify(
                        fIcon,
                        color: Colors.white,
                        size: 16,
                      ),
                      text: "fat",
                      remaining: () {
                        if (cubit.fat == 0) {
                          return "Add your Target Now !";
                        } else if (cubit.fat - cubit.currentFat <= 0) {
                          return "Congrats You Finished it !";
                        } else {
                          return "${cubit.fat - cubit.currentFat} Remaining";
                        }
                      }(),
                      color: const Color(0xff33a3b2),
                      percent: (cubit.currentFat.toInt() / cubit.fat).isNaN ||
                              (cubit.currentFat.toInt() / cubit.fat)
                                  .isNegative ||
                              (cubit.currentFat.toInt() / cubit.fat)
                                  .isInfinite ||
                              (cubit.currentFat.toInt() / cubit.fat) > 1
                          ? 0
                          : (cubit.currentFat.toInt() / cubit.fat),
                    ),
                    NutritionContainer(
                      widget: Iconify(
                        ironIcon,
                        color: Colors.white,
                        size: 16,
                      ),
                      text: "iron",
                      remaining: () {
                        if (cubit.iron == 0) {
                          return "Add your Target Now !";
                        } else if (cubit.iron - cubit.currentIron <= 0) {
                          return "Congrats You Finished it !";
                        } else {
                          return "${cubit.iron - cubit.currentIron} Remaining";
                        }
                      }(),
                      color: const Color(0xff7da1c3),
                      percent: (cubit.currentIron.toInt() / cubit.iron).isNaN ||
                              (cubit.currentIron.toInt() / cubit.iron)
                                  .isNegative ||
                              (cubit.currentIron.toInt() / cubit.iron)
                                  .isInfinite ||
                              (cubit.currentIron.toInt() / cubit.iron) > 1
                          ? 0
                          : (cubit.currentIron.toInt() / cubit.iron),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "  Food",
                      style: GoogleFonts.itim(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: const Color(0xff535707)),
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
