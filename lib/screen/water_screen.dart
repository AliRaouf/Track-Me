import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:track_me/blocs/water/water_cubit.dart';
import 'package:track_me/components/custom_button.dart';

class WaterScreen extends StatelessWidget {
  const WaterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var targetController = TextEditingController();
    var numberController = TextEditingController();
    var cubit = WaterCubit.get(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xfffafafa),
      appBar: AppBar(
        backgroundColor: const Color(0xfffafafa),
        centerTitle: true,
        leading: IconButton(
            color: const Color(0xff1142D9),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined)),
        title: Text(
          "Water",
          style: GoogleFonts.itim(color: const Color(0xff1142D9), fontSize: 32),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text(
            "How Much Water Do you want to Drink?",
            style: GoogleFonts.itim(fontSize: 18),
          ),
          TextField(
              keyboardType: TextInputType.number,
              controller: targetController,
              decoration: InputDecoration(
                constraints: BoxConstraints.tight(
                    Size(screenWidth * 0.5, screenHeight * 0.08)),
                hintText: cubit.userGender == "Male" || cubit.userGender == null
                    ? "Recommended is 3.7L"
                    : "Recommended is 2.7L",
                hintStyle: GoogleFonts.itim(fontSize: 18),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xff1142D9))),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.grey)),
              )),
          CustomButton(
              screenWidth: screenWidth * 0.2,
              screenHeight: screenHeight * 0.05,
              text: "Save",
              onpressed: () {},
              bColor: const Color(0xff1142D9),
              tColor: Colors.white),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: screenWidth * 0.38,
                height: screenHeight * 0.45,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/filled_bottle.png"))),
              ),
              Container(
                margin: EdgeInsets.only(top: screenHeight * 0.03),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("15 Cups Remaining",
                        style: GoogleFonts.itim(
                            fontSize: 20, color: const Color(0xff1142D9))),
                    Container(
                        margin: EdgeInsets.only(top: screenHeight * 0.02),
                        child: CircularPercentIndicator(
                          circularStrokeCap: CircularStrokeCap.round,
                          progressColor: const Color(0xff1142D9),
                          percent: 0.2,
                          lineWidth: 12,
                          radius: screenWidth * 0.2,
                          center: Text(
                            " 1.5L \n   / \n 3.5L",
                            style: GoogleFonts.itim(fontSize: 24),
                          ),
                        )),
                    Container(
                      width: screenWidth * 0.3,
                      height: screenHeight * 0.07,
                      margin: EdgeInsets.only(top: screenHeight * 0.05),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                const MaterialStatePropertyAll(Color(0xff2157FF)),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)))),
                        onPressed: () {},
                        child: Text(
                          "Add a Cup\n   250mL",
                          style: GoogleFonts.itim(
                              color: Colors.white, fontSize: 15),
                        ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: const Color(0xff2157FF),
                      borderRadius: BorderRadius.circular(999)),
                  child: IconButton(
                      onPressed: () {},
                      icon: const Iconify(
                        '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="currentColor" d="M19 13H5v-2h14z"/></svg>',
                        color: Colors.white,
                        size: 32,
                      ))),
              Container(
                margin: const EdgeInsets.only(top: 15),
                child: TextField(textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    controller: numberController,
                    decoration: InputDecoration(
                      constraints: BoxConstraints.tight(
                          Size(screenWidth * 0.22, screenHeight * 0.08)),
                      hintText: "100mL",
                      hintStyle: GoogleFonts.itim(fontSize: 18),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xff1142D9))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.grey)),
                    )),
              ),
              Container(
                  decoration: BoxDecoration(
                      color: const Color(0xff2157FF),
                      borderRadius: BorderRadius.circular(999)),
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.add,
                        size: 32,
                        color: Colors.white,
                      ))),
            ],
          ),
        ]),
      ),
    );
  }
}
