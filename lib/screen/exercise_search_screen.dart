import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:track_me/blocs/exercise/exercise_cubit.dart';
import 'package:track_me/components/custom_text_field.dart';
import 'package:track_me/components/exercise_list.dart';

class ExerciseSearchScreen extends StatelessWidget {
  const ExerciseSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    var cubit=ExerciseCubit.get(context);
    return Scaffold(appBar: AppBar(
      backgroundColor: Color(0xfffafafa),
      centerTitle: true,
      leading: IconButton(
          color: Color(0xff9932CC),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined)),
      title: Text(
        "Exercises",
        style: GoogleFonts.itim(color: Color(0xff9932CC), fontSize: 32),
      ),
    ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 24),
            child: CustomTextField(
              controller: searchController,
              color: Color(0xff9932CC),
              onPressed: () {
                cubit.getExercise("name", searchController.text.toLowerCase());
              },
            ),
          ),
          ExerciseList(
          )
        ],
      ),
    );
  }
}
