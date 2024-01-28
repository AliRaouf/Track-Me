import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:track_me/models/ingredient_model.dart';
import 'package:track_me/models/recipe_model.dart';

class SingleFoodScreen extends StatelessWidget {
  const SingleFoodScreen({super.key, this.recipe, this.ingredient, this.index});

  final RecipeModel? recipe;
  final IngredientModel? ingredient;
  final int? index;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      backgroundColor: const Color(0xfffafafa),
      appBar: AppBar(
        backgroundColor: const Color(0xfffafafa),
        centerTitle: true,
        leading: IconButton(
            color: const Color(0xffFF8000),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined)),
        title: Text(
          "${recipe?.results?[index!].title ?? ingredient?.name}",
          style: GoogleFonts.itim(color: const Color(0xffFF8000), fontSize: 24),
        ),
      ),
      body: recipe != null
          ? Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: screenHeight * 0.02),
                width: screenWidth,
                height: screenHeight * 0.27,
                child: Image(
                    image: NetworkImage(
                      "${recipe?.results?[index!].image}",
                    ),
                    fit: BoxFit.cover),
              ),
              Row(
                children: [
                  Text(
                    "Recipe",
                    style: GoogleFonts.itim(
                        color: const Color(0xffff8000), fontSize: 18),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xfffafafa),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                width: screenWidth,
                height: screenHeight * 0.24,
                margin: EdgeInsets.only(bottom: screenHeight * 0.02),
                child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: recipe?.results?[index!]
                        .analyzedInstructions?[0].steps?.length,
                    itemBuilder: (context, count) {
                      return Text(
                        "${recipe?.results?[index!].analyzedInstructions?[0]
                            .steps?[count].number}) ${recipe?.results?[index!]
                            .analyzedInstructions?[0].steps![count].step}",
                        style: GoogleFonts.itim(),
                      );
                    }),
              ),
              Row(
                children: [
                  Text(
                    "Nutrition",
                    style: GoogleFonts.itim(
                        color: const Color(0xffff8000), fontSize: 18),
                  ),
                ],
              ),
              Container(
                  decoration: BoxDecoration(
                    color: const Color(0xfffafafa),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 5,
                        spreadRadius: 1,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  width: screenWidth,
                  height: screenHeight * 0.24,
                  margin: EdgeInsets.only(bottom: screenHeight * 0.01),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                            "Serving Size: ${recipe?.results?[index!].nutrition
                                ?.weightPerServing?.amount}${recipe
                                ?.results?[index!].nutrition?.weightPerServing
                                ?.unit}",
                            style: GoogleFonts.itim()),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${recipe?.results?[index!].nutrition
                                  ?.nutrients?[0].name}: ${recipe
                                  ?.results?[index!].nutrition?.nutrients?[0]
                                  .amount}${recipe?.results?[index!].nutrition
                                  ?.nutrients?[0].unit}",
                              style: GoogleFonts.itim(),
                            ),
                            Text(
                              "${recipe?.results?[index!].nutrition
                                  ?.nutrients?[1].name}: ${recipe
                                  ?.results?[index!].nutrition?.nutrients?[1]
                                  .amount}${recipe?.results?[index!].nutrition
                                  ?.nutrients?[1].unit}",
                              style: GoogleFonts.itim(),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${recipe?.results?[index!].nutrition
                                  ?.nutrients?[3].name}: ${recipe
                                  ?.results?[index!].nutrition?.nutrients?[3]
                                  .amount}${recipe?.results?[index!].nutrition
                                  ?.nutrients?[3].unit}",
                              style: GoogleFonts.itim(),
                            ),
                            Text(
                              "${recipe?.results?[index!].nutrition
                                  ?.nutrients?[2].name}: ${recipe
                                  ?.results?[index!].nutrition?.nutrients?[2]
                                  .amount}${recipe?.results?[index!].nutrition
                                  ?.nutrients?[2].unit}",
                              style: GoogleFonts.itim(),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${recipe?.results?[index!].nutrition
                                  ?.nutrients?[4].name}: ${recipe
                                  ?.results?[index!].nutrition?.nutrients?[4]
                                  .amount}${recipe?.results?[index!].nutrition
                                  ?.nutrients?[4].unit}",
                              style: GoogleFonts.itim(),
                            ),
                            Text(
                              "${recipe?.results?[index!].nutrition
                                  ?.nutrients?[12].name}: ${recipe
                                  ?.results?[index!].nutrition?.nutrients?[12]
                                  .amount}${recipe?.results?[index!].nutrition
                                  ?.nutrients?[12].unit}",
                              style: GoogleFonts.itim(),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${recipe?.results?[index!].nutrition
                                  ?.nutrients?[8].name}: ${recipe
                                  ?.results?[index!].nutrition?.nutrients?[8]
                                  .amount}${recipe?.results?[index!].nutrition
                                  ?.nutrients?[8].unit}",
                              style: GoogleFonts.itim(),
                            ),
                            Text(
                              "${recipe?.results?[index!].nutrition
                                  ?.nutrients?[11].name}: ${recipe
                                  ?.results?[index!].nutrition?.nutrients?[11]
                                  .amount}${recipe?.results?[index!].nutrition
                                  ?.nutrients?[11].unit}",
                              style: GoogleFonts.itim(),
                            ),
                          ],
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Nutrition",
                  style: GoogleFonts.itim(
                      color: const Color(0xffff8000), fontSize: 18),
                ),
              ],
            ),
            Container(
                decoration: BoxDecoration(
                  color: const Color(0xfffafafa),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                width: screenWidth,
                height: screenHeight * 0.2,
                margin: EdgeInsets.only(bottom: screenHeight * 0.01),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                          "Serving Size: ${ingredient!.servingSizeG?.toInt()}g",
                          style: GoogleFonts.itim()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Calories: ${ingredient?.calories}kcal",
                            style: GoogleFonts.itim(),
                          ),
                          Text(
                            "Fat: ${ingredient?.fatTotalG}g",
                            style: GoogleFonts.itim(),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Carbohydrates: ${ingredient
                                ?.carbohydratesTotalG}g",
                            style: GoogleFonts.itim(),
                          ),
                          Text(
                            "Fiber: ${ingredient?.fiberG}g",
                            style: GoogleFonts.itim(),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Saturated Fat: ${ingredient?.fatTotalG}g",
                            style: GoogleFonts.itim(),
                          ),
                          Text(
                            "Protein: ${ingredient?.proteinG}g",
                            style: GoogleFonts.itim(),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
