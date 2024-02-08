import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:track_me/blocs/exercise/exercise_cubit.dart';

class SingleFavoriteExerciseScreen extends StatefulWidget {
  SingleFavoriteExerciseScreen({
    super.key,
    required this.data,
  });

  final DocumentSnapshot data;

  @override
  State<SingleFavoriteExerciseScreen> createState() =>
      _SingleFavoriteExerciseScreenState();
}

class _SingleFavoriteExerciseScreenState
    extends State<SingleFavoriteExerciseScreen> {
  @override
  Widget build(BuildContext context) {
    List<dynamic> instructions = widget.data['instructions'];
    List<dynamic> secondaryMuscles = widget.data['secondaryMuscles'];
    var cubit = ExerciseCubit.get(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocConsumer<ExerciseCubit, ExerciseState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            forceMaterialTransparency: true,
            backgroundColor: const Color(0xfffafafa),
            centerTitle: true,
            leading: IconButton(
                color: const Color(0xff9932CC),
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new_outlined)),
            title: Text(
              "${widget.data["name"]}",
              style: GoogleFonts.itim(
                  color: const Color(0xff9932CC), fontSize: 20),
            ),
            actions: [
              IconButton(
                  onPressed: () async {
                    await cubit.removeFromFavorite(widget.data["name"]);
                    print(cubit.isExist);
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
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.4,
                    child:
                        Image(image: NetworkImage("${widget.data["image"]}")),
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
                                  Text(": ${widget.data["bodyPart"]}",
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
                                  Text(": ${widget.data["target"]}",
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
                                  Text(": ${widget.data["equipment"]}",
                                      style: GoogleFonts.itim(fontSize: 15)),
                                ],
                              ),
                              Text(
                                "Secondary Muscles",
                                style: GoogleFonts.itim(
                                    color: const Color(0xff9932CC),
                                    fontSize: 16),
                              ),
                              for (int i = 0; i < secondaryMuscles.length; i++)
                                Text("${i + 1}) ${secondaryMuscles[i]}",
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
                            for (int i = 0; i < instructions.length; i++)
                              Text("${i + 1}) ${instructions[i]}",
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
