import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:track_me/models/exercise_model.dart';

import '../../services/exercise_dio.dart';

part 'exercise_state.dart';

class ExerciseCubit extends Cubit<ExerciseState> {
  ExerciseCubit() : super(ExerciseInitial());
  static ExerciseCubit get(context) => BlocProvider.of(context);
  ExerciseModel? exerciseModel;
  List<ExerciseModel>? exerciseList;
  getExercise(type,search) {
    emit(GetExerciseLoading());
    ExerciseDio.getData(type,search).then((value) {
      List<ExerciseModel> exercises = ExerciseModel.fromJsonList(value.data);
      exerciseList=exercises;
      print(value.statusCode);
      emit(GetExerciseSuccess());
    });
  }
}
