import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:track_me/screen/exercise_favorites_screen.dart';
import 'package:track_me/screen/exercise_screen.dart';

import '../blocs/exercise/exercise_cubit.dart';
import '../screen/exercise_search_screen.dart';

class ExerciseBottomAppBar extends StatelessWidget {
  ExerciseBottomAppBar({
    required this.color,
    super.key,
  });

  Color color;

  String ironIcon =
      '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="#fafafa" d="M20.57 14.86L22 13.43L20.57 12L17 15.57L8.43 7L12 3.43L10.57 2L9.14 3.43L7.71 2L5.57 4.14L4.14 2.71L2.71 4.14l1.43 1.43L2 7.71l1.43 1.43L2 10.57L3.43 12L7 8.43L15.57 17L12 20.57L13.43 22l1.43-1.43L16.29 22l2.14-2.14l1.43 1.43l1.43-1.43l-1.43-1.43L22 16.29z"/></svg>';

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
        width: screenWidth * 0.8,
        height: screenHeight * 0.08,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(30)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: screenWidth * 0.27,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ExerciseScreen()));
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.transparent),
                    elevation: MaterialStatePropertyAll(0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Iconify(ironIcon, color: Color(0xff9932CC)),
                    Text(
                      "Exercises",
                      style: GoogleFonts.itim(
                          color: Color(0xff9932CC),
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: screenWidth * 0.265,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ExerciseSearchScreen()));
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.transparent),
                  elevation: MaterialStatePropertyAll(0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search_sharp, color: Color(0xff9932CC)),
                    Text(
                      "Search",
                      style: GoogleFonts.itim(
                          color: Color(0xff9932CC),
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: screenWidth * 0.265,
              child: ElevatedButton(
                onPressed: ()async{
                  await ExerciseCubit.get(context).receiveExerciseList();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ExerciseFavoriteScreen()));
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.transparent),
                  elevation: MaterialStatePropertyAll(0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.favorite_border_rounded,
                        color: Color(0xff9932CC)),
                    Text(
                      "Favorites",
                      style: GoogleFonts.itim(
                          color: Color(0xff9932CC),
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
