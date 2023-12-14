import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:track_me/blocs/food/food_cubit.dart';

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
                  child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: "Search Here!",
                        hintStyle: GoogleFonts.itim(fontSize: 18),
                        contentPadding: EdgeInsets.symmetric(horizontal: 8),
                        suffixIcon: IconButton(
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
                            },
                            icon: Icon(Icons.search),
                            color: Color(0xffF49E47)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.grey)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.grey)),
                      )),
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
                                  return Container(
                                    height: screenHeight * 0.1,
                                    margin: EdgeInsets.symmetric(vertical: 8),
                                    decoration: BoxDecoration(
                                        color: Color(0xffFFD37E),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  "${cubit.recipeModel?.results?[index].title}",
                                                  style: GoogleFonts.itim(
                                                      fontSize: 16,
                                                      color: Color(0xff252525),
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: screenWidth * 0.255,
                                                child: Text(
                                                    "Cal:${cubit.recipeModel?.results?[index].nutrition?.nutrients?[0].amount}",
                                                    style: GoogleFonts.itim(
                                                        fontSize: 12,
                                                        color:
                                                            Color(0xff252525))),
                                              ),
                                              Container(
                                                width: screenWidth * 0.26,
                                                child: Text(
                                                    "Prot:${cubit.recipeModel?.results?[index].nutrition?.nutrients?[8].amount}",
                                                    style: GoogleFonts.itim(
                                                        fontSize: 12,
                                                        color:
                                                            Color(0xff252525))),
                                              ),
                                              Container(
                                                width: screenWidth * 0.26,
                                                child: Text(
                                                    "Carb:${cubit.recipeModel?.results?[index].nutrition?.nutrients?[3].amount}",
                                                    style: GoogleFonts.itim(
                                                        fontSize: 12,
                                                        color:
                                                            Color(0xff252525))),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          )
                        : cubit.ingredientModel==null?SizedBox.shrink():
                Container(
                            height: screenHeight * 0.1,
                            width: screenWidth * 0.82,
                            margin: EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                                color: Color(0xffFFD37E),
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          "${cubit.ingredientModel?.name}",
                                          style: GoogleFonts.itim(
                                              fontSize: 16,
                                              color: Color(0xff252525),
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: screenWidth * 0.255,
                                        child: Text(
                                            "Cal:${cubit.ingredientModel?.calories}",
                                            style: GoogleFonts.itim(
                                                fontSize: 12,
                                                color: Color(0xff252525))),
                                      ),
                                      Container(
                                        width: screenWidth * 0.26,
                                        child: Text(
                                            "Prot:${cubit.ingredientModel?.proteinG}",
                                            style: GoogleFonts.itim(
                                                fontSize: 12,
                                                color: Color(0xff252525))),
                                      ),
                                      Container(
                                        width: screenWidth * 0.26,
                                        child: Text(
                                            "Carb:${cubit.ingredientModel?.carbohydratesTotalG}",
                                            style: GoogleFonts.itim(
                                                fontSize: 12,
                                                color: Color(0xff252525))),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
              ]),
            ));
      },
    );
  }
}
