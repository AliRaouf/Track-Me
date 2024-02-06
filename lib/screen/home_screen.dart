import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:track_me/blocs/exercise/exercise_cubit.dart';
import 'package:track_me/blocs/nutrition/nutrition_cubit.dart';
import 'package:track_me/blocs/user/user_cubit.dart';
import 'package:track_me/blocs/water/water_cubit.dart';
import 'package:track_me/components/gradient_text.dart';
import 'package:track_me/screen/change_password.dart';
import 'package:track_me/screen/exercise_screen.dart';
import 'package:track_me/screen/food_screen.dart';
import 'package:track_me/screen/nutrition_screen.dart';
import 'package:track_me/screen/profile_screen.dart';

import '../components/custom_container.dart';
import 'water_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    NutritionCubit.get(context).getUserData();
    NutritionCubit.get(context).receiveFoodList();
    NutritionCubit.get(context).createNutritionDataSet();
    NutritionCubit.get(context).receiveNutrition();
    NutritionCubit.get(context).receiveFoodList();
    WaterCubit.get(context).getUser();
    WaterCubit.get(context).getUserGender();
    WaterCubit.get(context).receiveWater();
    WaterCubit.get(context).createWaterDataSet();
    Future.delayed(Duration(milliseconds: 1000), () {
      WaterCubit.get(context).waterPercent();
    });
    ExerciseCubit.get(context).getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var cubit = UserCubit.get(context);
    return BlocConsumer<UserCubit, UserState>(listener: (context, state) {
      if (state is UserSignOutSuccessState) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Logged out Successfully")));
      }
      if (state is ReceiveUserNameLoadingState ||
          state is ReceiveUserNameErrorState) {
        const CircularProgressIndicator();
      }
    }, builder: (context, state) {
      return BlocConsumer<WaterCubit, WaterState>(
        listener: (context, state) {
          if (state is ReceiveWaterSuccess){
            WaterCubit.get(context).waterPercent();
          }
          if (state is WaterPercentSuccess) {
            setState(() {});
          }
        },
        builder: (context, waterState) {
          return Scaffold(
            backgroundColor: const Color(0xfffafafa),
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: const Color(0xfffafafa),
              iconTheme: const IconThemeData(color: Color(0xff00A4FB)),
              title: GradientText(
                "Welcome ${cubit.userName ?? ""}",
                style: GoogleFonts.itim(fontWeight: FontWeight.bold),
                gradient: const LinearGradient(
                  colors: [Color(0xff00a4fb), Color(0xff00fb93)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
            drawer: Container(
              color: const Color(0xfffafafa),
              width: screenWidth * 0.7,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  SizedBox(
                    width: screenWidth * 0.5,
                    height: screenHeight * 0.2,
                    child: Image.asset("assets/images/logo.png"),
                  ),
                  SizedBox(
                    height: screenHeight * 0.165,
                    child: Stack(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 50.0),
                          child: Divider(
                            height: 20,
                            color: Colors.black,
                          ),
                        ),
                        Positioned(
                            left: 20,
                            child: CircleAvatar(
                              radius: 64,
                              backgroundImage: NetworkImage(cubit.imageUrl),
                              backgroundColor: Colors.white,
                              onBackgroundImageError: (exception, stackTrace) {
                                setState(() {
                                  cubit.imageUrl =
                                      'https://static.vecteezy.com/system/resources/previews/009/292/244/original/default-avatar-icon-of-social-media-user-vector.jpg';
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(999),
                                    border: Border.all(
                                        width: 2, color: Colors.black)),
                              ),
                            ))
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          "  ${cubit.userName ?? ""}",
                          style: GoogleFonts.itim(fontSize: 24),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfileScreen()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Icon(
                            size: 28,
                            Icons.person_outline_rounded,
                            color: Color(0xff00A4FB),
                          ),
                          Text(
                            " Profile",
                            style: GoogleFonts.itim(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ChangePasswordScreen()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Icon(
                            size: 28,
                            Icons.password_outlined,
                            color: Color(0xff00A4FB),
                          ),
                          Text(
                            " Change Password",
                            style: GoogleFonts.itim(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      cubit.userSignOut(context);
                      WaterCubit.get(context).waterP=0;
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Icon(
                            size: 28,
                            Icons.logout,
                            color: Color(0xff00A4FB),
                          ),
                          Text(
                            " Logout",
                            style: GoogleFonts.itim(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  )
                ]),
              ),
            ),
            body: ListView(children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    children: [
                      CustomContainer(
                        screenWidth: screenWidth * 0.9,
                        screenHeight: screenHeight * 0.17,
                        color: const Color(0xfff49e49),
                        text:
                            'Find Food Recipes \nand Their \nNutritional Value',
                        widget: Image.asset("assets/images/burger.png"),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const FoodScreen()));
                        },
                      ),
                      CustomContainer(
                        screenWidth: screenWidth * 0.9,
                        screenHeight: screenHeight * 0.17,
                        text: "Track Your Nutritions !",
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xff535707),
                            Color(0xffCDBF4C),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        widget: Image.asset("assets/images/avocado.png",
                            fit: BoxFit.fill),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NutritionScreen()));
                        },
                      ),
                      CustomContainer(
                        screenWidth: screenWidth * 0.9,
                        screenHeight: screenHeight * 0.17,
                        image: const DecorationImage(
                            image: AssetImage("assets/images/gym.png"),
                            fit: BoxFit.cover),
                        text: 'Search For New Exercises !',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ExerciseScreen()));
                        },
                      ),
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          CustomContainer(
                            color: const Color(0xff2a9bff),
                            screenWidth: screenWidth * 0.9,
                            screenHeight: screenHeight * 0.17,
                            text:
                                "Track your Water\nConsumption\nYou are ${(WaterCubit.get(context).waterP * 100).toInt()}% there \nKeep Drinking !",
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WaterScreen()));
                            },
                          ),
                          Container(
                              height: screenHeight * 0.2,
                              margin: EdgeInsets.only(left: screenWidth * 0.7),
                              child: Image.asset("assets/images/water.png")),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ]),
          );
        },
      );
    });
  }
}
