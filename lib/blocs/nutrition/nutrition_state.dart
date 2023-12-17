part of 'nutrition_cubit.dart';

@immutable
abstract class NutritionState {}

class NutritionInitial extends NutritionState {}
class SaveFoodLoading extends NutritionState {}
class SaveFoodSuccess extends NutritionState {}
class SaveFoodError extends NutritionState {}
class ReceiveFoodLoading extends NutritionState {}
class ReceiveFoodSuccess extends NutritionState {}
class ReceiveFoodError extends NutritionState {}

