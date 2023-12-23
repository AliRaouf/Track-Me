
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:track_me/models/exercise_model.dart';

class SingleExerciseScreen extends StatelessWidget {
  List<ExerciseModel>? exerciseList;
  final int index;

  SingleExerciseScreen(
      {super.key, required this.exerciseList, required this.index});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfffafafa),
        centerTitle: true,
        leading: IconButton(
            color: Color(0xff9932CC),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined)),
        title: Text(
          "${exerciseList![index].name}",
          style: GoogleFonts.itim(color: Color(0xff9932CC), fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Center(
          child: Column(
            children: [
              Container(
                height: screenHeight * 0.4,
                child:
                    Image(image: NetworkImage("${exerciseList![index].gifUrl}")),
              ),
              Container(
                child: Row(
                  children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("BodyPart ",style: GoogleFonts.itim(color:Color(0xff9932CC),fontSize: 16),),
                            Text(": ${exerciseList![index].bodyPart}",style: GoogleFonts.itim(fontSize: 15)),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Targets ",style: GoogleFonts.itim(color:Color(0xff9932CC),fontSize: 16),),
                            Text(": ${exerciseList![index].target}",style: GoogleFonts.itim(fontSize: 15)),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Equipment ",style: GoogleFonts.itim(color:Color(0xff9932CC),fontSize: 16),),
                            Text(": ${exerciseList![index].equipment}",style: GoogleFonts.itim(fontSize: 15)),
                          ],
                        ),
                        Text("Secondary Muscles",style: GoogleFonts.itim(color:Color(0xff9932CC),fontSize: 16),),
                        for(int i=0; i < exerciseList![index].secondaryMuscles!.length;i++)
                          Text("${i+1}) ${exerciseList![index].secondaryMuscles![i]}",style: GoogleFonts.itim(fontSize: 15))
                          ]
                    ),
                  ],
                ),
              ),Row(
                children: [
                  Text("Instructions",style: GoogleFonts.itim(color: Color(0xff9932CC),fontSize: 16),),
                ],
              ),
              Flexible(
                child: Container(width: screenWidth,color: Colors.transparent,
                  child: ListView(
                    children: [
                      for(int i=0; i < exerciseList![index].instructions!.length;i++)
                        Text("${i+1}) ${exerciseList![index].instructions![i]}",style: GoogleFonts.itim(fontSize: 15))
                    ],
                  )
                
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
