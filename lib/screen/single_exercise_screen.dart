import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:track_me/blocs/exercise/exercise_cubit.dart';
import 'package:track_me/models/exercise_model.dart';

class SingleExerciseScreen extends StatefulWidget {
  List<ExerciseModel>? exerciseList;
  final int index;

  SingleExerciseScreen(
      {super.key, required this.exerciseList, required this.index});

  @override
  State<SingleExerciseScreen> createState() => _SingleExerciseScreenState();
}

class _SingleExerciseScreenState extends State<SingleExerciseScreen> {
  @override
  Widget build(BuildContext context) {
    var cubit = ExerciseCubit.get(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocConsumer<ExerciseCubit, ExerciseState>(
      listener: (context, state) {
        if (state is SaveExerciseSuccess) {
          setState(() {});
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            forceMaterialTransparency: true,
            actions: [
              IconButton(
                  onPressed: () {
                    String exerciseName = (widget.exerciseList![widget.index].name == "3/4 sit-up")
                        ? "3 to 4 sit up"
                        : widget.exerciseList![widget.index].name!;
                    if(cubit.isExist==false) {
                      setState(() {
                        ExerciseCubit.get(context).saveExercise(
                          exerciseName,
                          "${widget.exerciseList![widget.index].bodyPart}",
                          "${widget.exerciseList![widget.index].equipment}",
                          "${widget.exerciseList![widget.index].target}",
                          "${widget.exerciseList![widget.index].gifUrl}",
                          widget.exerciseList![widget.index].instructions,
                          widget.exerciseList![widget.index].secondaryMuscles,
                        );
                      });
                      print(cubit.isExist);
                    }else if(cubit.isExist==true){
                      cubit.removeFromFavorite(exerciseName);
                    }
                  },
                  icon: (cubit.isExist ?? false)
                      ? Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : Icon(
                          Icons.favorite_border,
                          color: Colors.grey,
                        ))
            ],
            backgroundColor: const Color(0xfffafafa),
            centerTitle: true,
            leading: IconButton(
                color: const Color(0xff9932CC),
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new_outlined)),
            title: Text(
              "${widget.exerciseList![widget.index].name}",
              style: GoogleFonts.itim(
                  color: const Color(0xff9932CC), fontSize: 20),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.4,
                    child: Image(
                        image: NetworkImage(
                            "${widget.exerciseList![widget.index].gifUrl}")),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "BodyPart ",
                                    style: GoogleFonts.itim(
                                        color: const Color(0xff9932CC),
                                        fontSize: 16),
                                  ),
                                  Text(
                                      ": ${widget.exerciseList![widget.index].bodyPart}",
                                      style: GoogleFonts.itim(fontSize: 15)),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Targets ",
                                    style: GoogleFonts.itim(
                                        color: const Color(0xff9932CC),
                                        fontSize: 16),
                                  ),
                                  Text(
                                      ": ${widget.exerciseList![widget.index].target}",
                                      style: GoogleFonts.itim(fontSize: 15)),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Equipment ",
                                    style: GoogleFonts.itim(
                                        color: const Color(0xff9932CC),
                                        fontSize: 16),
                                  ),
                                  Text(
                                      ": ${widget.exerciseList![widget.index].equipment}",
                                      style: GoogleFonts.itim(fontSize: 15)),
                                ],
                              ),
                              Text(
                                "Secondary Muscles",
                                style: GoogleFonts.itim(
                                    color: const Color(0xff9932CC),
                                    fontSize: 16),
                              ),
                              for (int i = 0;
                                  i <
                                      widget.exerciseList![widget.index]
                                          .secondaryMuscles!.length;
                                  i++)
                                Text(
                                    "${i + 1}) ${widget.exerciseList![widget.index].secondaryMuscles![i]}",
                                    style: GoogleFonts.itim(fontSize: 15))
                            ]),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Instructions",
                        style: GoogleFonts.itim(
                            color: const Color(0xff9932CC), fontSize: 16),
                      ),
                    ],
                  ),
                  Flexible(
                    child: Container(
                        width: screenWidth,
                        color: Colors.transparent,
                        child: ListView(
                          children: [
                            for (int i = 0;
                                i <
                                    widget.exerciseList![widget.index]
                                        .instructions!.length;
                                i++)
                              Text(
                                  "${i + 1}) ${widget.exerciseList![widget.index].instructions![i]}",
                                  style: GoogleFonts.itim(fontSize: 15))
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
