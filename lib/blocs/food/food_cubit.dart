import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:track_me/models/recipe_model.dart';
import 'package:track_me/services/food_dio.dart';

part 'food_state.dart';

class FoodCubit extends Cubit<FoodState> {
  FoodCubit() : super(FoodInitial());
  static FoodCubit get(context) => BlocProvider.of(context);
  RecipeModel? recipeModel;
  getRecipe(recipe){
  emit(GetRecipeLoading());
  FoodDio.getData(recipe).then((value) {
    emit(GetRecipeSuccess());
    recipeModel=RecipeModel.fromJson(value.data);
    print(recipeModel!.results![0].title);
    print(value.statusCode);
  }
  );
  }
  initApi(){
    FoodDio.init();
}
}
