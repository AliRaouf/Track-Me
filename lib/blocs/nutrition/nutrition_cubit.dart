import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'dart:async';

part 'nutrition_state.dart';

class NutritionCubit extends Cubit<NutritionState> {
  NutritionCubit() : super(NutritionInitial());
  User? user;
  Stream? foodStream;
  Stream? nutritionStream;
  int calories = 0;
  int carbs = 0;
  int fiber = 0;
  int iron = 0;
  int protein = 0;
  int fat = 0;
  int currentCalories = 0;
  int currentCarbs = 0;
  int currentFiber = 0;
  int currentIron = 0;
  int currentProtein = 0;
  int currentFat = 0;

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
      foodStream = FirebaseFirestore.instance
          .collection('nutrition')
          .doc(user?.email)
          .collection('foodLog')
          .snapshots();
      emit(ReceiveFoodSuccess());
      print("Food Received Successfully");
      print(foodStream!.length);
    } on Exception catch (e) {
      print('Error receiving food entry: $e');
      emit(ReceiveFoodError());
    }
  }

  receiveNutrition() async {
    emit(ReceiveNutritionLoading());
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('nutrition')
              .doc(user?.email)
              .collection('Nutrition')
              .get();
      calories = querySnapshot.docs.first.get("calories");
      carbs = querySnapshot.docs.first.get("carbohydrates");
      iron = querySnapshot.docs.first.get("iron");
      fat = querySnapshot.docs.first.get("fat");
      fiber = querySnapshot.docs.first.get("fiber");
      protein = querySnapshot.docs.first.get("protein");
      currentCalories = querySnapshot.docs.first.get("currentCalories");
      currentCarbs = querySnapshot.docs.first.get("currentCarbohydrates");
      currentIron = querySnapshot.docs.first.get("currentIron");
      currentFat = querySnapshot.docs.first.get("currentFat");
      currentFiber = querySnapshot.docs.first.get("currentFiber");
      currentProtein = querySnapshot.docs.first.get("currentProtein");
      emit(ReceiveNutritionSuccess());
      print(
          "carbs = $carbs , Calories=$calories ,remaining calories= $currentCalories");
    } on Exception catch (e) {
      print('Error adding food entry: $e');
      emit(ReceiveNutritionError());
    }
  }

  createNutritionDataSet() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentReference userDocRef =
          firestore.collection("nutrition").doc(user!.email);

      if ((await userDocRef.collection("Nutrition").get()).docs.isEmpty &&
          user!.email != null) {
        await userDocRef.collection("Nutrition").add({
          "calories": 0,
          "protein": 0,
          "fiber": 0,
          "iron": 0,
          "carbohydrates": 0,
          "fat": 0,
          "currentCalories": 0,
          "currentProtein": 0,
          "currentFiber": 0,
          "currentIron": 0,
          "currentCarbohydrates": 0,
          "currentFat": 0,
        });
        print('Nutrition entry added for ${user!.email}');
        startDailyResetTimer();
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
      DocumentSnapshot doc = nutritionSnapshot.docs.first;
      await doc.reference.update(updatedData);
      print("Document updated Successfully");
      emit(UpdateNutritionSuccess());
    } on Exception catch (e) {
      print(e);
      emit(UpdateNutritionError());
    }
  }

  addToCurrentNutrition(calorie, protein, carb, fiber, fat, iron) async {
    emit(AddToCurrentNutritionLoading());
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot nutritionSnapshot = await firestore
        .collection("nutrition")
        .doc(user!.email)
        .collection("Nutrition")
        .limit(1)
        .get();
    DocumentSnapshot doc = nutritionSnapshot.docs.first;
    await doc.reference.update({
      "currentCalories": FieldValue.increment(calorie),
      "currentCarbohydrates": FieldValue.increment(carb),
      "currentProtein": FieldValue.increment(protein),
      "currentFat": FieldValue.increment(fat),
      "currentFiber": FieldValue.increment(fiber),
      "currentIron": FieldValue.increment(iron),
    });
    emit(AddToCurrentNutritionSuccess());
  }

  String formatTime(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();

    return DateFormat('EEE, hh:mm a').format(dateTime);
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
      resetNutritionValues();
      Timer.periodic(resetInterval, (Timer timer) {
        resetNutritionValues();
      });
    });
  }

  resetNutritionValues() async {
    emit(ResetNutritionValueSuccess());
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot nutritionSnapshot = await firestore
          .collection("nutrition")
          .doc(user!.email)
          .collection("Nutrition")
          .limit(1)
          .get();
      DocumentSnapshot doc = nutritionSnapshot.docs.first;
      await doc.reference.update({
        "calories": 0,
        "protein": 0,
        "fiber": 0,
        "iron": 0,
        "carbohydrates": 0,
        "fat": 0,
        "currentCalories": 0,
        "currentProtein": 0,
        "currentFiber": 0,
        "currentIron": 0,
        "currentCarbohydrates": 0,
        "currentFat": 0,
      });
      emit(ResetNutritionValueSuccess());
    } on Exception catch (e) {
      emit(ResetNutritionValueError());
      print(e);
    }
  }
}
