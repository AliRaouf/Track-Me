part of 'nutrition_cubit.dart';

@immutable
abstract class NutritionState {}

class NutritionInitial extends NutritionState {}
class SaveFoodLoading extends NutritionState {}
class SaveFoodSuccess extends NutritionState {}
class SaveFoodError extends NutritionState {}
class ReceiveNutritionLoading extends NutritionState {}
class ReceiveNutritionSuccess extends NutritionState {}
class ReceiveNutritionError extends NutritionState {}
class ReceiveFoodLoading extends NutritionState {}
class ReceiveFoodSuccess extends NutritionState {}
class ReceiveFoodError extends NutritionState {}
class UpdateNutritionLoading extends NutritionState {}
class UpdateNutritionSuccess extends NutritionState {}
class UpdateNutritionError extends NutritionState {}
class AddToCurrentNutritionLoading extends NutritionState {}
class AddToCurrentNutritionSuccess extends NutritionState {}
class AddToCurrentNutritionError extends NutritionState {}
class ResetNutritionValueSuccess extends NutritionState {}
class ResetNutritionValueLoading extends NutritionState {}
class ResetNutritionValueError extends NutritionState {}



