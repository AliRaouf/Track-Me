import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:track_me/blocs/food/food_cubit.dart';
import 'package:track_me/screen/single_food_screen.dart';

import '../components/custom_text_field.dart';
import '../components/food_container.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({super.key});

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

enum Food {
  Recipe,
  Ingredient,
}

Food FoodView = Food.Recipe;

class _FoodScreenState extends State<FoodScreen> {
  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var cubit = FoodCubit.get(context);
    return BlocConsumer<FoodCubit, FoodState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xfffafafa),
              centerTitle: true,
              leading: IconButton(
                  color: Color(0xffFF8000),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_outlined)),
              title: Text(
                "Food",
                style: GoogleFonts.itim(color: Color(0xffFF8000), fontSize: 32),
              ),
            ),
            body: Center(
              child: Column(children: [
                SegmentedButton<Food>(
                  emptySelectionAllowed: false,
                  showSelectedIcon: false,
                  style: ButtonStyle(
                      textStyle: MaterialStatePropertyAll(
                          GoogleFonts.itim(fontSize: 16)),
                      backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.selected)) {
                          return Color(0xffFF9000);
                        } else {
                          return Color(0xfffafafa);
                        }
                      })),
                  segments: const <ButtonSegment<Food>>[
                    ButtonSegment<Food>(
                        value: Food.Recipe, label: Text('Recipe')),
                    ButtonSegment<Food>(
                        value: Food.Ingredient, label: Text('Ingredient')),
                  ],
                  selected: <Food>{FoodView},
                  onSelectionChanged: (Set<Food> newSelection) {
                    setState(() {
                      FoodView = newSelection.first;
                    });
                  },
                ),
                Container(
                  width: screenWidth * 0.85,
                  margin: EdgeInsets.symmetric(vertical: screenHeight * 0.03),
                  decoration: BoxDecoration(
                    color: Color(0xfffafafa),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 5,
                        spreadRadius: 1,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: CustomTextField(
                      controller: searchController,
                  onPressed: () {
                    if (cubit.recipeModel == null &&
                        cubit.ingredientModel == null)
                      CircularProgressIndicator();
                    {
                      if (FoodView == Food.Recipe) {
                        cubit.getRecipe(searchController.text);
                        print(searchController.text);
                      } else if (FoodView == Food.Ingredient) {
                        cubit.getIngredient(searchController.text);
                        print(searchController.text);
                      }
                    }
                  },color: Color(0xffF49E47),
                  ),
                ),
                cubit.recipeModel == null && cubit.ingredientModel == null
                    ? SizedBox.shrink()
                    : FoodView == Food.Recipe
                        ? Expanded(
                            child: ListView.builder(
                                padding: EdgeInsets.symmetric(horizontal: 32),
                                itemCount:
                                    cubit.recipeModel?.results?.length ?? 0,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return FoodContainer(
                                    ontap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              SingleFoodScreen(
                                            recipe: cubit.recipeModel,
                                            index: index,
                                          ),
                                        ),
                                      );
                                    },
                                    Height: screenHeight * 0.144,
                                    title: cubit
                                        .recipeModel?.results?[index].title,
                                    carbs: cubit.recipeModel?.results?[index]
                                        .nutrition?.nutrients?[0].amount,
                                    protein: cubit.recipeModel?.results?[index]
                                        .nutrition?.nutrients?[8].amount,
                                    calories: cubit.recipeModel?.results?[index]
                                        .nutrition?.nutrients?[3].amount,
                                  );
                                }),
                          )
                        : cubit.ingredientModel == null
                            ? SizedBox.shrink()
                            : FoodContainer(
                                ontap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => SingleFoodScreen(
                                        ingredient: cubit.ingredientModel,
                                        index: 0,
                                      ),
                                    ),
                                  );
                                },
                                Height: screenHeight * 0.1,
                                Width: screenWidth * 0.82,
                                title: cubit.ingredientModel!.name,
                                calories: cubit.ingredientModel!.calories,
                                carbs:
                                    cubit.ingredientModel!.carbohydratesTotalG,
                                protein: cubit.ingredientModel!.proteinG,
                              )
              ]),
            ));
      },
    );
  }
}
