import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'dart:async';

part 'water_state.dart';

class WaterCubit extends Cubit<WaterState> {
  WaterCubit() : super(WaterInitial());
  static WaterCubit get(context) => BlocProvider.of(context);
  String? userGender;
  User? user;
  int goal=0;
  int currentWater=0;
  double waterP=0.0;
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
      startDailyResetTimer();
      emit(ReceiveWaterSuccess());
      print("Water Received Successfully");
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
    emit(WaterPercentLoading());
    try {
      if(currentWater/goal <= 0){

        waterP=0.0;
        emit(WaterPercentSuccess());
      }else if(currentWater/goal <=1){
        waterP=currentWater/goal;
        emit(WaterPercentSuccess());
      }else if((currentWater/goal).isNaN){
        waterP=0.0;
        print("Water Percent Received Successfully");
        emit(WaterPercentSuccess());
      }else{
        print("Water Percent Received Successfully");
        waterP=1.0;
        emit(WaterPercentSuccess());
      }
    } on Exception catch (e) {
      emit(WaterPercentError());
      print(e);
    }
  }
  startDailyResetTimer() {
    DateTime now = DateTime.now();
    DateTime next6AM = DateTime(now.year, now.month, now.day, 6, 0);
    if (now.isAfter(next6AM)) {
      next6AM = next6AM.add(Duration(days: 1));
    }
    Duration initialDelay = next6AM.difference(now);
    const Duration resetInterval = Duration(hours: 24);
    Timer(initialDelay, () {
      resetWaterValues();
      Timer.periodic(resetInterval, (Timer timer) {
        resetWaterValues();
      });
    });
  }
  resetWaterValues() async {
    emit(ResetWaterValueSuccess());
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot waterSnapshot = await firestore
          .collection("Water")
          .doc(user!.email)
          .collection("Water")
          .limit(1)
          .get();
      DocumentSnapshot doc = waterSnapshot.docs.first;
      await doc.reference.update({
        "currentWater": 0,
        "goal":0
      });
      emit(ResetWaterValueSuccess());
    } on Exception catch (e) {
      emit(ResetWaterValueError());
      print(e);
    }
  }
}
