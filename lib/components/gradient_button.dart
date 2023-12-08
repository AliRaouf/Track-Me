import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.screenWidth,
    required this.screenHeight, required this.text, required this.onpressed,
  });

  final double screenWidth;
  final double screenHeight;
  final String text;
  final void Function()? onpressed;

  @override
  Widget build(BuildContext context) {
    return Container(width: screenWidth,height: screenHeight,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          colors: [Color(0xff00fb93), Color(0xff00a4fb)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.transparent),
            shadowColor: MaterialStatePropertyAll(Colors.transparent),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)))),
        onPressed:onpressed,
        child: Text(text,style: TextStyle(color: Color(0xfffafafa),fontSize: 22),),
      ),
    );
  }
}