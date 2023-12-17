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

  saveFood(name, calories, description, protein, fiber, fat, carb, iron,date) {
    emit(SaveFoodLoading());
    try{
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
        "date":date
      });
      print('Food entry added for ${user?.email}');
      emit(SaveFoodSuccess());
    }catch(e){
      print('Error adding food entry: $e');
      emit(SaveFoodError());
    }
  }
  receiveFoodList(){
    try {
      foodStream=FirebaseFirestore.instance.collection('nutrition').doc(user?.email).collection('foodLog').snapshots();
      emit(ReceiveFoodSuccess());
    } on Exception catch (e) {
      print('Error adding food entry: $e');
      emit(ReceiveFoodError());
    }
  }
  String formatTime(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();

    return DateFormat('EEE, hh:mm a').format(dateTime);
  }
}
