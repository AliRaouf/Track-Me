import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'water_state.dart';

class WaterCubit extends Cubit<WaterState> {
  WaterCubit() : super(WaterInitial());
  static WaterCubit get(context) => BlocProvider.of(context);
  String? userGender;
  User? user;
  int goal=0;
  int currentWater=0;
  getUser()
  {
    user=FirebaseAuth.instance.currentUser;
  }
  getUserGender() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: user!.email)
        .get();
    var userData = snapshot.docs.first;
    userGender=userData["gender"];
    print(userGender);

  }
  createWaterDataSet() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentReference userDocRef = firestore.collection("Water").doc(user!.email);

      if ((await userDocRef.collection("Water").get()).docs.isEmpty && user!.email != null) {
        await userDocRef.collection("Water").add({
          "goal": 0,
          "currentWater": 0,
        });
        print('Water entry added for ${user!.email}');

      } else {
        print('Water entry already exists for ${user!.email}');

      }
    } catch (e) {
      print('Error adding or checking Water entry: $e');
    }
  }
  
  updateWaterData(Map<String, dynamic> updatedData) async {
    emit(UpdateWaterLoading());
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      QuerySnapshot waterSnapshot = await firestore
          .collection("Water")
          .doc(user!.email)
          .collection("Water")
          .limit(1)
          .get();
      DocumentSnapshot doc=waterSnapshot.docs.first;
      await doc.reference.update(updatedData);
      print("Document updated Successfully");
      emit(UpdateWaterSuccess());
    } on Exception catch (e) {
      print(e);
      emit(UpdateWaterError());
    }
  }

  receiveWater() async {
    emit(ReceiveWaterLoading());
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await
      FirebaseFirestore.instance.collection('Water').doc(user?.email)
          .collection('Water')
          .get();
      goal=querySnapshot.docs.first.get("goal");
      currentWater=querySnapshot.docs.first.get("currentWater");
      emit(ReceiveWaterSuccess());
    } on Exception catch (e) {
      print('Error adding food entry: $e');
      emit(ReceiveWaterError());
    }
  }
  addToCurrentWater(water) async {
    emit(AddToCurrentWaterLoading());
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot waterSnapshot = await firestore
        .collection("Water")
        .doc(user!.email)
        .collection("Water")
        .limit(1).get();
    DocumentSnapshot doc=waterSnapshot.docs.first;
    await doc.reference.update({
      "currentWater": FieldValue.increment(water),
    });
    emit(AddToCurrentWaterSuccess());
  }
  waterPercent(){
    if(currentWater/goal <= 0){
      return 0.0;
    }else if(currentWater/goal <=1){
      return currentWater/goal;
    }else if((currentWater/goal).isNaN){
      return 0.0;
    }else{
      return 1.0;
    }
  }
}
