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
  Stream? nutritionStream;
  int? calories;
  int? carbs;
  int? fiber;
  int? iron;
  int? protein;
  int? fat;
  int currentCalories=0;
  int currentCarbs=0;
  int currentFiber=0;
  int currentIron=0;
  int currentProtein=0;
  int currentFat=0;

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
    emit(ReceiveFoodLoading());
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
  receiveNutrition() async {
    emit(ReceiveNutritionLoading());
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await
          FirebaseFirestore.instance.collection('nutrition').doc(user?.email)
              .collection('Nutrition')
              .get();
      calories=querySnapshot.docs.first.get("calories");
      carbs=querySnapshot.docs.first.get("carbohydrates");
      iron=querySnapshot.docs.first.get("iron");
      fat=querySnapshot.docs.first.get("fat");
      fiber=querySnapshot.docs.first.get("fiber");
      protein=querySnapshot.docs.first.get("protein");
      emit(ReceiveNutritionSuccess());
      print("carbs = $carbs , Calories=$calories ,remaining calories= $currentCalories");
    } on Exception catch (e) {
      print('Error adding food entry: $e');
      emit(ReceiveNutritionError());
    }
  }

  createNutritionDataSet() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentReference userDocRef = firestore.collection("nutrition").doc(user!.email);

      if ((await userDocRef.collection("Nutrition").get()).docs.isEmpty && user!.email != null) {
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
    emit(UpdateNutritionLoading());
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
      emit(UpdateNutritionSuccess());
    } on Exception catch (e) {
      print(e);
      emit(UpdateNutritionError());
    }

  }
  String formatTime(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();

    return DateFormat('EEE, hh:mm a').format(dateTime);
  }

}

