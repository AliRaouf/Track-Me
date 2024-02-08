import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:track_me/blocs/exercise/exercise_cubit.dart';
import 'package:track_me/components/exercise_bottom_app_bar.dart';
import 'package:track_me/components/favorite_list.dart';

import 'exercise_screen.dart';

class ExerciseFavoriteScreen extends StatefulWidget {
  const ExerciseFavoriteScreen({super.key});

  @override
  State<ExerciseFavoriteScreen> createState() => _ExerciseFavoriteScreenState();
}

class _ExerciseFavoriteScreenState extends State<ExerciseFavoriteScreen> {
  @override
  void initState() {
    ExerciseCubit.get(context).receiveExerciseList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var cubit = ExerciseCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: const Color(0xfffafafa),
        centerTitle: true,
        leading: IconButton(
            color: const Color(0xff9932CC),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ExerciseScreen()));
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined)),
        title: Text(
          "Favorites",
          style: GoogleFonts.itim(color: const Color(0xff9932CC), fontSize: 32),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24),
              ),
              FavoriteList(exerciseStream: cubit.exerciseStream!)
            ],
          ),
          Positioned(
              left: screenWidth * 0.1,
              top: screenHeight * 0.8,
              child: ExerciseBottomAppBar(color: Color(0x4F9F9F9F)))
        ],
      ),
    );
  }
}
