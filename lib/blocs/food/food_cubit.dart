import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:track_me/models/ingredient_model.dart';
import 'package:track_me/models/recipe_model.dart';
import 'package:track_me/services/food_dio.dart';
import 'package:track_me/services/ingredient_dio.dart';

part 'food_state.dart';

class FoodCubit extends Cubit<FoodState> {
  FoodCubit() : super(FoodInitial());

  static FoodCubit get(context) => BlocProvider.of(context);
  RecipeModel? recipeModel;
  IngredientModel? ingredientModel;

  getRecipe(recipe) {
    emit(GetRecipeLoading());
    FoodDio.getData(recipe, "/recipes/complexSearch").then((value) {
      emit(GetRecipeSuccess());
      recipeModel = RecipeModel.fromJson(value.data);
      print(recipeModel!.results![0].title);
      print(value.statusCode);
    }
    );
  }

  getIngredient(ingredient) {
    emit(GetIngredientLoading());
    IngredientDio.getData(query: ingredient).then((value) {
      emit(GetIngredientSuccess());
      ingredientModel = IngredientModel.fromList(value.data);
      print(ingredientModel!.name);
      print(value.statusCode);
    });
  }

  initApi() {
    FoodDio.init();
    IngredientDio.init();
  }
}