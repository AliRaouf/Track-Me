import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:track_me/blocs/exercise/exercise_cubit.dart';
import 'package:track_me/screen/single_exercise_screen.dart';

class ExerciseList extends StatelessWidget {
  const ExerciseList({super.key,});
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var cubit = ExerciseCubit.get(context);
    return Expanded(
      child: ListView.builder(
          itemCount: cubit.exerciseList?.length ?? 10,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  GestureDetector(onTap:(){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SingleExerciseScreen(index: index, exerciseList:cubit.exerciseList )));
                  } ,
                    child: Container(
                      width: screenWidth * 0.8,height: screenHeight*0.213,
                      decoration: BoxDecoration(color: const Color(0xffCDB3F7),borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Exercise Name: ${cubit.exerciseList?[index].name}",style:GoogleFonts.itim(),overflow: TextOverflow.fade,),
                                  Text("Body Part: ${cubit.exerciseList?[index].bodyPart}",style:GoogleFonts.itim()),
                                  Text("Targets: ${cubit.exerciseList?[index].target}",style:GoogleFonts.itim()),
                                ],
                              ),
                            ),ClipRRect(borderRadius: BorderRadius.circular(15),
                                child: Image(image: NetworkImage("${cubit.exerciseList?[index].gifUrl}")))
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
