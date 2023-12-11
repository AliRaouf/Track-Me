import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:track_me/blocs/user/user_cubit.dart';
import 'package:track_me/components/gradient_text.dart';
import 'package:track_me/screen/food_screen.dart';

import '../components/custom_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var cubit = UserCubit.get(context);
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Color(0xfffafafa),
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Color(0xfffafafa),
            iconTheme: IconThemeData(color: Color(0xff00A4FB)),
            title: GradientText(
              "Welcome ${cubit.userName ?? ""}",
              style: GoogleFonts.itim(fontWeight: FontWeight.bold),
              gradient: LinearGradient(
                colors: [Color(0xff00a4fb), Color(0xff00fb93)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          drawer: Container(
            color: Color(0xfffafafa),
            width: screenWidth * 0.7,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(children: [
                SizedBox(
                  width: screenWidth * 0.5,
                  height: screenHeight * 0.2,
                  child: Container(
                    child: Image.asset("assets/images/logo.png"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "  ${cubit.userName ?? ""}",
                        style: GoogleFonts.itim(fontSize: 25),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.person_outline_rounded,
                        color: Color(0xff00A4FB),
                      ),
                      Text(" Profile")
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.password_outlined,
                        color: Color(0xff00A4FB),
                      ),
                      Text(" Change Password")
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: Color(0xff00A4FB),
                      ),
                      Text(" Logout")
                    ],
                  ),
                )
              ]),
            ),
          ),
          body: Center(
            child: Column(
              children: [
                CustomContainer(
                  screenWidth: screenWidth * 0.9,
                  screenHeight: screenHeight * 0.17,
                  color: Color(0xfff49e49),
                  text: 'Find Food Recipes \nand Their \nNutritional Value',
                  widget: Image.asset("assets/images/burger.png"),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => FoodScreen()));
                  },
                ),
                CustomContainer(
                  screenWidth: screenWidth * 0.9,
                  screenHeight: screenHeight * 0.17,
                  text: "Track Your Nutritions !",
                  gradient: LinearGradient(
                    colors: [Color(0xffCDBF4C), Color(0xff535707)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  widget: Image.asset("assets/images/avocado.png",
                      fit: BoxFit.fill),
                  onTap: () {},
                ),
                CustomContainer(
                  screenWidth: screenWidth * 0.9,
                  screenHeight: screenHeight * 0.17,
                  image: DecorationImage(
                      image: AssetImage("assets/images/gym.png"),
                      fit: BoxFit.cover),
                  text: 'Search For New Exercises !',
                  onTap: () {},
                ),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    CustomContainer(
                      color: Color(0xff479DF4),
                      screenWidth: screenWidth * 0.9,
                      screenHeight: screenHeight * 0.17,
                      text:
                          "Track your Water\nConsumption\nYou are 0% there \nKeep Drinking !",
                      onTap: () {},
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
        );
      },
    );
  }
}
