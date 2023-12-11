import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:track_me/components/food_list.dart';

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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
                  textStyle:
                      MaterialStatePropertyAll(GoogleFonts.itim(fontSize: 16)),
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.selected)) {
                      return Color(0xffFF9000);
                    } else {
                      return Color(0xfffafafa);
                    }
                  })),
              segments: const <ButtonSegment<Food>>[
                ButtonSegment<Food>(value: Food.Recipe, label: Text('Recipe')),
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
                  decoration: InputDecoration(
                hintText: "Search Here!",
                hintStyle: GoogleFonts.itim(fontSize: 18),
                contentPadding: EdgeInsets.symmetric(horizontal: 8),
                suffixIcon: IconButton(
                    onPressed: () {},
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
            Container(
              width: screenWidth * 0.8,
              height: screenHeight * 0.08,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("Recipe Name"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Calories:900",
                        style: TextStyle(fontSize: 12),
                      ),
                      Text("Protein:900", style: TextStyle(fontSize: 12)),
                      Text("Carbs:900", style: TextStyle(fontSize: 12))
                    ],
                  )
                ],
              ),
            )
          ]),
        ));
  }
}
