part of 'food_cubit.dart';

@immutable
abstract class FoodState {}

class FoodInitial extends FoodState {}
class GetIngredientLoading extends FoodState {}
class GetIngredientSuccess extends FoodState {}
class GetIngredientError extends FoodState {}
class GetRecipeLoading extends FoodState {}
class GetRecipeSuccess extends FoodState {}
class GetRecipeError extends FoodState {}

