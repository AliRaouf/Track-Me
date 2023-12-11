import 'package:flutter/material.dart';

class FoodList extends StatelessWidget {
  const FoodList({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return ListView.builder(physics: BouncingScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index){
      Container(width: screenWidth*0.8,height: screenHeight*0.08,
      child: Column(
        children: [
          Text("Recipe Name")
          ,Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Calories:900"),Text("Protein:900"),Text("Carbs:900")
          ],)
        ],
      ),);
        });
  }
}
