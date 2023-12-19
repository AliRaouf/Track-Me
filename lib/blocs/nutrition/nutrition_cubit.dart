import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'nutrition_state.dart';

class NutritionCubit extends Cubit<NutritionState> {
  NutritionCubit() : super(NutritionInitial());
  User? user;
  Stream? foodStream;

  static NutritionCubit get(context) => BlocProvider.of(context);

  getUserData() {
    user = FirebaseAuth.instance.currentUser;
  }

  saveFood(name, calories, description, protein, fiber, fat, carb, iron, date) {
    emit(SaveFoodLoading());
    try {
      FirebaseFirestore.instance
          .collection("nutrition")
          .doc(user!.email)
          .collection("foodLog")
          .add({
        "description": description,
        "name": name,
        "calories": calories,
        "protein": protein,
        "fiber": fiber,
        "iron": iron,
        "carbohydrates": carb,
        "fat": fat,
        "date": date
      });
      print('Food entry added for ${user?.email}');
      emit(SaveFoodSuccess());
    } catch (e) {
      print('Error adding food entry: $e');
      emit(SaveFoodError());
    }
  }

  receiveFoodList() {
    try {
      foodStream =
          FirebaseFirestore.instance.collection('nutrition').doc(user?.email)
              .collection('foodLog')
              .snapshots();
      emit(ReceiveFoodSuccess());
    } on Exception catch (e) {
      print('Error adding food entry: $e');
      emit(ReceiveFoodError());
    }
  }

  createNutritionDataSet() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentReference userDocRef = firestore.collection("nutrition").doc(user!.email);

      if ((await userDocRef.collection("Nutrition").get()).docs.isEmpty) {
        // If the subcollection doesn't have any documents, add a new one
        await userDocRef.collection("Nutrition").add({
          "calories": 0,
          "protein": 0,
          "fiber": 0,
          "iron": 0,
          "carbohydrates": 0,
          "fat": 0,
        });
        print('Nutrition entry added for ${user!.email}');

      } else {
        print('Nutrition entry already exists for ${user!.email}');

      }
    } catch (e) {
      print('Error adding or checking Nutrition entry: $e');
    }
  }
  updateNutritionData(Map<String, dynamic> updatedData) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      QuerySnapshot nutritionSnapshot = await firestore
          .collection("nutrition")
          .doc(user!.email)
          .collection("Nutrition")
          .limit(1)
          .get();
      DocumentSnapshot doc=nutritionSnapshot.docs.first;
      await doc.reference.update(updatedData);
      print("Document updated Successfully");
    } on Exception catch (e) {
      print(e);
    }

  }
  String formatTime(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();

    return DateFormat('EEE, hh:mm a').format(dateTime);
  }

}

