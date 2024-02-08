part of 'exercise_cubit.dart';

@immutable
abstract class ExerciseState {}

class ExerciseInitial extends ExerciseState {}
class GetExerciseLoading extends ExerciseState {}
class GetExerciseSuccess extends ExerciseState {}
class GetExerciseError extends ExerciseState {}
class SaveExerciseLoading extends ExerciseState {}
class SaveExerciseSuccess extends ExerciseState {}
class SaveExerciseError extends ExerciseState {}
class CheckExerciseLoading extends ExerciseState {}
class ExerciseExists extends ExerciseState {}
class ExerciseDoesntExist extends ExerciseState {}
class CheckExerciseSuccess extends ExerciseState {}
class ReceiveExerciseLoading extends ExerciseState {}
class ReceiveExerciseSuccess extends ExerciseState {}
class ReceiveExerciseError extends ExerciseState {}
class RemoveExerciseLoading extends ExerciseState {}
class RemoveExerciseSuccess extends ExerciseState {}
class RemoveExerciseError extends ExerciseState {}