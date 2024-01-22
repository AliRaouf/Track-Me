import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:track_me/components/exercise_dropdown.dart';
import 'package:track_me/components/target_dropdown.dart';
import 'package:track_me/screen/exercise_search_screen.dart';

import '../blocs/exercise/exercise_cubit.dart';
import '../components/custom_button.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({super.key});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  var exerciseController = TextEditingController();
  var targetController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var cubit=ExerciseCubit.get(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocConsumer<ExerciseCubit, ExerciseState>(
  listener: (context, state) {
    if(state is GetExerciseSuccess){
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ExerciseSearchScreen()));
    }
  },
  builder: (context, state) {
    return Scaffold(
      backgroundColor: Color(0xfffafafa),
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/images/exercise_bg.png"),
          fit: BoxFit.cover,
        )),
        child: Center(
            child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Color(0xfffafafa)),
          width: screenWidth * 0.7,
          height: screenHeight * 0.5,
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  "Select only one of them",
                  style:
                      GoogleFonts.itim(color: Colors.black87, fontSize: 20),
                ),
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                  child: ExerciseDropDown(controller: exerciseController,)),
              Container(margin: EdgeInsets.only(bottom: screenHeight*0.05),
                  child: TargetDropDown(controller: targetController,)),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomButton(
                    screenWidth: screenWidth * 0.25,
                    screenHeight: screenHeight * 0.05,
                    text: 'Close',
                    onpressed: () {
                      Navigator.pop(context);
                    }, bColor: Colors.white,sColor: Color(0xff9932CC), tColor: Color(0xff9932CC),
                  ),
                  CustomButton(
                    screenWidth: screenWidth * 0.25,
                    screenHeight: screenHeight * 0.05,
                    text: 'Search',
                    onpressed: () {
                      print("${targetController.text}");
                      targetController.text==""?
                      cubit.getExercise("bodyPart",exerciseController.text.toLowerCase()):
                      cubit.getExercise("target",targetController.text.toLowerCase());
                    }, bColor:Color(0xff9932CC), tColor: Color(0xfffafafa),
                  )
                ],
              )
            ],
          ),
        )),
      ),
    );
  },
);
  }
}
