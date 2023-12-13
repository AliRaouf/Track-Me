part of 'food_cubit.dart';

@immutable
abstract class FoodState {}

class FoodInitial extends FoodState {}
class GetRecipeLoading extends FoodState {}
class GetRecipeSuccess extends FoodState {}
class GetRecipeError extends FoodState {}
