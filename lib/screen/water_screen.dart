import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:track_me/blocs/water/water_cubit.dart';
import 'package:track_me/components/custom_button.dart';
import 'package:track_me/components/custom_text_field.dart';
import 'package:track_me/components/resetDialog.dart';

class WaterScreen extends StatefulWidget {
  WaterScreen({super.key});

  @override
  State<WaterScreen> createState() => _WaterScreenState();
}

class _WaterScreenState extends State<WaterScreen> {
  var targetController = TextEditingController();

  var numberController = TextEditingController();

  @override
  void initState() {
    WaterCubit.get(context).receiveWater();
    WaterCubit.get(context).waterPercent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = WaterCubit.get(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocConsumer<WaterCubit, WaterState>(
      listener: (context, state) {
        if(state is UpdateWaterSuccess){
          setState(() {
            cubit.waterPercent();
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Color(0xfffafafa),
          appBar: AppBar(
            backgroundColor: Color(0xfffafafa),
            centerTitle: true,
            leading: IconButton(
                color: Color(0xff1142D9),
                onPressed: () {
                  Navigator.pop(context);
                  cubit.waterPercent();
                },
                icon: Icon(Icons.arrow_back_ios_new_outlined)),
            title: Text(
              "Water",
              style: GoogleFonts.itim(color: Color(0xff1142D9), fontSize: 32),
            ),
            actions: [
              GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return ResetDialog();
                        });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Icon(Icons.restart_alt_outlined,
                        color: Color(0xff1142D9)),
                  ))
            ],
          ),
          body: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "How Much Water Do you want to Drink?",
                        style: GoogleFonts.itim(fontSize: 18),
                      ),
                      Container(
                        width: screenWidth * 0.56,
                        margin:
                            EdgeInsets.symmetric(vertical: screenHeight * 0.03),
                        child: CustomTextField(
                          hint: cubit.userGender == "Male" ||
                                  cubit.userGender == null
                              ? "Recommended is 3700mL"
                              : "Recommended is 2700mL",
                          type: TextInputType.number,
                          controller: targetController,
                          obscureText: false,
                          readOnly: false,
                        ),
                      ),
                      CustomButton(
                        screenWidth: screenWidth * 0.2,
                        screenHeight: screenHeight * 0.05,
                        text: "Save",
                        onpressed: () async {
                          await cubit.updateWaterData(
                              {"goal": int.parse(targetController.text)});
                          await cubit.receiveWater();
                          cubit.waterPercent();
                          setState(() {});
                        },
                        bColor: Color(0xff1142D9),
                        tColor: Colors.white,
                        fontSize: 13, borderColor: Colors.white,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: screenWidth * 0.38,
                            height: screenHeight * 0.45,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage((cubit.currentWater /
                                                cubit.goal) <=
                                            0.5
                                        ? "assets/images/empty_bottle.png"
                                        : "assets/images/filled_bottle.png"))),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: screenHeight * 0.03),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    "${((cubit.goal - cubit.currentWater) / 250).toInt() <= 0 ? 0 : ((cubit.goal - cubit.currentWater) / 250).toInt()} Cups Remaining",
                                    style: GoogleFonts.itim(
                                        fontSize: 20,
                                        color: Color(0xff1142D9))),
                                Container(
                                    margin: EdgeInsets.only(
                                        top: screenHeight * 0.02),
                                    child: CircularPercentIndicator(
                                      circularStrokeCap:
                                          CircularStrokeCap.round,
                                      progressColor: Color(0xff1142D9),
                                      percent: cubit.waterP,
                                      lineWidth: 12,
                                      radius: screenWidth * 0.2,
                                      center: Text(
                                        " ${(cubit.currentWater / 1000) < 0 ? 0.0 : cubit.currentWater / 1000}L \n   / \n ${cubit.goal / 1000}L",
                                        style: GoogleFonts.itim(fontSize: 24),
                                      ),
                                    )),
                                Container(
                                  width: screenWidth * 0.3,
                                  height: screenHeight * 0.07,
                                  margin:
                                      EdgeInsets.only(top: screenHeight * 0.05),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: CustomButton(
                                    text: "Add a Cup\n   250mL",
                                    onpressed: () async {
                                      await cubit.addToCurrentWater(250);
                                      await cubit.receiveWater();
                                      cubit.waterPercent();
                                      setState(() {});
                                    },
                                    screenWidth: screenWidth * 0.2,
                                    screenHeight: screenHeight * 0.1,
                                    bColor: Color(0xff2456fa),
                                    tColor: Colors.white,
                                    fontSize: 15, borderColor: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Text(
                        "How Much Did You Drink?",
                        style: GoogleFonts.itim(fontSize: 18),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                                margin: EdgeInsets.only(),
                                decoration: BoxDecoration(
                                    color: Color(0xff2157FF),
                                    borderRadius: BorderRadius.circular(999)),
                                child: IconButton(
                                    onPressed: () async {
                                      if (cubit.currentWater -
                                              int.parse(numberController.text) <
                                          0) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "The number will be less than Zero")));
                                      } else if (cubit.currentWater <= 0) {
                                        null;
                                      } else {
                                        await cubit.addToCurrentWater(
                                            -int.parse(numberController.text));
                                        await cubit.receiveWater();
                                        cubit.waterPercent();
                                        setState(() {});
                                      }
                                    },
                                    icon: Iconify(
                                      '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="currentColor" d="M19 13H5v-2h14z"/></svg>',
                                      color: Colors.white,
                                      size: 32,
                                    ))),
                            SizedBox(
                              width: screenWidth * 0.2,
                              child: CustomTextField(
                                hint: "100mL",
                                type: TextInputType.number,
                                controller: numberController,
                                obscureText: false,
                                readOnly: false,
                              ),
                            ),
                            Container(
                                decoration: BoxDecoration(
                                    color: Color(0xff2157FF),
                                    borderRadius: BorderRadius.circular(999)),
                                child: IconButton(
                                    onPressed: () async {
                                      await cubit.addToCurrentWater(
                                          int.parse(numberController.text));
                                      await cubit.receiveWater();
                                      cubit.waterPercent();
                                      setState(() {});
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      size: 32,
                                      color: Colors.white,
                                    ))),
                          ],
                        ),
                      ),
                    ]),
              ),
            ],
          ),
        );
      },
    );
  }
}
