import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:track_me/models/exercise_model.dart';

import '../../services/exercise_dio.dart';

part 'exercise_state.dart';

class ExerciseCubit extends Cubit<ExerciseState> {
  ExerciseCubit() : super(ExerciseInitial());

  static ExerciseCubit get(context) => BlocProvider.of(context);
  ExerciseModel? exerciseModel;
  Stream? exerciseStream;
  List<ExerciseModel>? exerciseList;
  User? user;
  bool? isExist;

  getUserData() {
    user = FirebaseAuth.instance.currentUser;
  }

  getExercise(type, search) {
    emit(GetExerciseLoading());
    ExerciseDio.getData(type, search).then((value) {
      List<ExerciseModel> exercises = ExerciseModel.fromJsonList(value.data);
      exerciseList = exercises;
      print(value.statusCode);
      emit(GetExerciseSuccess());
    });
  }

  checkExercise(name) async {
    emit(CheckExerciseLoading());
    final existingDocs = await FirebaseFirestore.instance
        .collection("exercises")
        .doc(user!.email)
        .collection("exerciseLog")
        .where("name", isEqualTo: name)
        .get();
    if (existingDocs.docs.isNotEmpty) {
      print('Document with name $name already exists');
      emit(ExerciseExists());
      isExist = true;
    } else {
      emit(ExerciseDoesntExist());
      isExist = false;
    }
    emit(CheckExerciseSuccess());
  }

  saveExercise(name,
      bodyPart,
      equipment,
      target,
      image,
      List<String>? instructions,
      List<String>? secondaryMuscles,) async {
    emit(SaveExerciseLoading());
    try {
      final existingDocs = await FirebaseFirestore.instance
          .collection("exercises")
          .doc(user!.email)
          .collection("exerciseLog")
          .where("name", isEqualTo: name)
          .get();

      if (existingDocs.docs.isNotEmpty) {
        print('Document with name $name already exists');
        emit(SaveExerciseError());
        return;
      }
      final exerciseData = {
        "name": name,
        "bodyPart": bodyPart,
        "equipment": equipment,
        "target": target,
        "image": image,
        "secondaryMuscles": secondaryMuscles,
        "instructions": instructions,
      };

      FirebaseFirestore.instance
          .collection("exercises")
          .doc(user!.email)
          .collection("exerciseLog")
          .doc(name)
          .set(exerciseData);

      print('Exercise entry added for ${user!.email}');
      await checkExercise(name);
      receiveExerciseList();
      emit(SaveExerciseSuccess());
    } catch (e) {
      print('Error adding exercise entry: $e');
      emit(SaveExerciseError());
    }
  }

  receiveExerciseList() {
    emit(ReceiveExerciseLoading());
    try {
      exerciseStream = FirebaseFirestore.instance
          .collection('exercises')
          .doc(user?.email)
          .collection('exerciseLog')
          .snapshots();
      emit(ReceiveExerciseSuccess());
      print("Exercises Received Successfully");
      print(exerciseStream!.length);
    } on Exception catch (e) {
      print('Error receiving Exercises entry: $e');
      emit(ReceiveExerciseError());
    }
  }

  removeFromFavorite(name) async {
    emit(RemoveExerciseLoading());
    try {
      await FirebaseFirestore.instance
          .collection("exercises")
          .doc(user!.email)
          .collection("exerciseLog")
          .doc(name)
          .delete();
      receiveExerciseList();
      checkExercise(name);
      emit(RemoveExerciseSuccess());
    } catch (e) {
      print('Error removing exercise: $e');
      emit(RemoveExerciseError());
    }
  }
}
