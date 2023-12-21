part of 'exercise_cubit.dart';

@immutable
abstract class ExerciseState {}

class ExerciseInitial extends ExerciseState {}
class GetExerciseLoading extends ExerciseState {}
class GetExerciseSuccess extends ExerciseState {}
class GetExerciseError extends ExerciseState {}