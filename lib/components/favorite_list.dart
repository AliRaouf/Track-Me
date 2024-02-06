import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:track_me/blocs/exercise/exercise_cubit.dart';
import 'package:track_me/screen/single_exercise_screen.dart';

class FavoriteList extends StatefulWidget {
  const FavoriteList({
    super.key,
    required this.exerciseStream,
  });

  final Stream exerciseStream;

  @override
  State<FavoriteList> createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    var cubit = ExerciseCubit.get(context);
    return StreamBuilder(
        stream: widget.exerciseStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            QuerySnapshot values = snapshot.data as QuerySnapshot;
            if (values.docs.isNotEmpty) {
              return Expanded(
                child: ListView.builder(
                    itemCount: values.docs.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                width: screenWidth * 0.8,
                                height: screenHeight * 0.213,
                                decoration: BoxDecoration(
                                    color: const Color(0xffCDB3F7),
                                    borderRadius:
                                    BorderRadius.circular(15)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Text(
                                              "Exercise Name: ${values
                                                  .docs[index]["name"]}",
                                              style:
                                              GoogleFonts.itim(),
                                              overflow:
                                              TextOverflow.fade,
                                            ),
                                            Text(
                                                "Body Part: ${values
                                                    .docs[index]["bodyPart"]}",
                                                style: GoogleFonts
                                                    .itim()),
                                            Text(
                                                "Targets: ${values
                                                    .docs[index]["target"]}",
                                                style: GoogleFonts
                                                    .itim()),
                                          ],
                                        ),
                                      ),
                                      ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(
                                              15),
                                          child: Image(
                                              image: NetworkImage(
                                                  "${values
                                                      .docs[index]["image"]}")))
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
            } else {
              return Text(
                "Start Adding Exercises!",
                style: GoogleFonts.itim(fontWeight: FontWeight.bold),
              );
            }
          } else {
            return SizedBox.shrink();
          }
        });
  }
}
