import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:track_me/components/exercise_dropdown.dart';
import 'package:track_me/components/target_dropdown.dart';
import 'package:track_me/screen/exercise_search_screen.dart';
import 'package:track_me/screen/home_screen.dart';

import '../blocs/exercise/exercise_cubit.dart';
import '../components/custom_button.dart';
import '../components/exercise_bottom_app_bar.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({super.key});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  var exerciseController = TextEditingController();
  var targetController = TextEditingController();
  @override
  void initState() {
ExerciseCubit.get(context).receiveExerciseList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var cubit = ExerciseCubit.get(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocConsumer<ExerciseCubit, ExerciseState>(
      listener: (context, state) {
        if (state is GetExerciseSuccess) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ExerciseSearchScreen()));
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xfffafafa),
          body: Stack(
            children: [
              Container(
                width: screenWidth,
                height: screenHeight,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("assets/images/exercise_bg.png"),
                  fit: BoxFit.cover,
                )),
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: const Color(0xfffafafa)),
                      width: screenWidth * 0.7,
                      height: screenHeight * 0.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Text(
                              "Select only one of them",
                              style: GoogleFonts.itim(
                                  color: Colors.black87, fontSize: 20),
                            ),
                          ),
                          Container(
                              child: ExerciseDropDown(
                            controller: exerciseController,
                          )),
                          Padding(
                            padding:
                                EdgeInsets.only(bottom: 12, left: 8, right: 8),
                            child: Divider(),
                          ),
                          Container(
                              child: TargetDropDown(
                            controller: targetController,
                          )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CustomButton(
                                fontSize: 13,
                                borderColor: Colors.white,
                                screenWidth: screenWidth * 0.25,
                                screenHeight: screenHeight * 0.05,
                                text: 'Close',
                                onpressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const HomeScreen()));
                                },
                                bColor: Colors.white,
                                sColor: const Color(0xff9932CC),
                                tColor: const Color(0xff9932CC),
                              ),
                              CustomButton(
                                borderColor: Colors.white,
                                screenWidth: screenWidth * 0.25,
                                screenHeight: screenHeight * 0.05,
                                text: 'Search',
                                onpressed: () {
                                  print(targetController.text);
                                  targetController.text == ""
                                      ? cubit.getExercise("bodyPart",
                                          exerciseController.text.toLowerCase())
                                      : cubit.getExercise("target",
                                          targetController.text.toLowerCase());
                                },
                                bColor: const Color(0xff9932CC),
                                tColor: const Color(0xfffafafa),
                                fontSize: 13,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
              ),
          Positioned(
            left: screenWidth * 0.1,
            top: screenHeight * 0.9,
            child: ExerciseBottomAppBar(color: Color(0x40FFFFFF)))
            ],
          ),
        );
      },
    );
  }
}


