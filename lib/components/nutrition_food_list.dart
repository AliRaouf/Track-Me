import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:track_me/blocs/nutrition/nutrition_cubit.dart';

class NutritionFoodList extends StatefulWidget {
  const NutritionFoodList({super.key, required this.foodStream});

  final Stream foodStream;

  @override
  State<NutritionFoodList> createState() => _NutritionFoodListState();
}

class _NutritionFoodListState extends State<NutritionFoodList> {
  @override
  void initState() {
    NutritionCubit.get(context).receiveFoodList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    String pIcon =
        '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="#fafafa" d="M9 7v10h2v-4h2a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2zm2 2h2v2h-2zm1-7a10 10 0 0 1 10 10a10 10 0 0 1-10 10A10 10 0 0 1 2 12A10 10 0 0 1 12 2"/></svg>';
    String cIcon =
        '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="#fafafa" d="M12 2a10 10 0 0 1 10 10a10 10 0 0 1-10 10A10 10 0 0 1 2 12A10 10 0 0 1 12 2m-1 5a2 2 0 0 0-2 2v6a2 2 0 0 0 2 2h2a2 2 0 0 0 2-2v-1h-2v1h-2V9h2v1h2V9a2 2 0 0 0-2-2z"/></svg>';
    String leafIcon =
        '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="#fafafa" d="M17 8C8 10 5.9 16.17 3.82 21.34l1.89.66l.95-2.3c.48.17.98.3 1.34.3C19 20 22 3 22 3c-1 2-8 2.25-13 3.25S2 11.5 2 13.5s1.75 3.75 1.75 3.75C7 8 17 8 17 8"/></svg>';
    String fIcon =
        '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="#fafafa" d="M12 2a10 10 0 0 1 10 10a10 10 0 0 1-10 10A10 10 0 0 1 2 12A10 10 0 0 1 12 2M9 7v10h2v-4h3v-2h-3V9h4V7z"/></svg>';
    String ironIcon =
        '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="#fafafa" d="M20.57 14.86L22 13.43L20.57 12L17 15.57L8.43 7L12 3.43L10.57 2L9.14 3.43L7.71 2L5.57 4.14L4.14 2.71L2.71 4.14l1.43 1.43L2 7.71l1.43 1.43L2 10.57L3.43 12L7 8.43L15.57 17L12 20.57L13.43 22l1.43-1.43L16.29 22l2.14-2.14l1.43 1.43l1.43-1.43l-1.43-1.43L22 16.29z"/></svg>';
    var cubit=NutritionCubit.get(context);
    return StreamBuilder(
        stream: widget.foodStream,
        builder: (context, snapshot) {
          QuerySnapshot values = snapshot.data as QuerySnapshot;
          if(snapshot.hasData && values.docs.length != 0){
          return Expanded(
              child: ListView.builder(
                  itemCount: values.docs.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                      child: Column(
                        children: [
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                values.docs[index]["name"],
                                style: GoogleFonts.itim(
                                    fontWeight: FontWeight.w500, fontSize: 18),
                              ),
                              Text(
                               cubit.formatTime(values.docs[index]["date"]??Timestamp(0,0)),
                              style: GoogleFonts.itim(
                                    fontSize: 12,color: Colors.blueGrey),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                values.docs[index]["description"],
                                style: GoogleFonts.itim(fontSize: 14,color: Colors.grey),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              values.docs[index]["calories"] == null || values.docs[index]["calories"] == 0
                                  ? SizedBox.shrink()
                                  : Icon(CupertinoIcons.flame_fill,size: 16,
                                      color: Colors.red),
                              values.docs[index]["calories"] == 0?Text(""):Text("${values.docs[index]["calories"]} "),
                              values.docs[index]["protein"] == null || values.docs[index]["protein"] == 0
                                  ? SizedBox.shrink()
                                  : Iconify(pIcon,color: Colors.orange,size: 18,),
                              values.docs[index]["protein"] == 0?Text(""):Text("${values.docs[index]["protein"]} "),
                              values.docs[index]["carbohydrates"] == null ||values.docs[index]["carbohydrates"] == 0
                                  ? SizedBox.shrink()
                                  : Iconify(cIcon,color: Colors.blue,size: 18),
                              values.docs[index]["carbohydrates"] == 0?Text(""):Text("${values.docs[index]["carbohydrates"]} "),
                              values.docs[index]["fat"] == null || values.docs[index]["fat"] == 0
                                  ? SizedBox.shrink()
                                  : Iconify(fIcon,color: Color(0xff33a3b2),size: 18),
                              values.docs[index]["fat"] == 0?Text(""):Text("${values.docs[index]["fat"]} "),
                              values.docs[index]["fiber"] == null || values.docs[index]["fiber"] == 0
                                  ? SizedBox.shrink()
                                  : Iconify(leafIcon,color: Colors.green,size: 18),
                              values.docs[index]["fiber"] == 0? Text(""):Text("${values.docs[index]["fiber"]} "),
                              values.docs[index]["iron"] == null || values.docs[index]["iron"] == 0
                                  ? SizedBox.shrink()
                                  : Iconify(ironIcon,color: Color(0xff7da1c3),size: 18),
                              values.docs[index]["iron"] == 0?Text(""):Text("${values.docs[index]["iron"]} "),
                            ],
                          )
                        ],
                      ),
                    );
                  }
                  )
          );
        }else{
            return Text("Add Food Now!",style: GoogleFonts.itim(fontWeight: FontWeight.bold),);
          }
        }
    );
  }
}
