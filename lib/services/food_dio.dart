import 'package:dio/dio.dart';

String apiKey="67dbf1f8abf44194a1c0281cf9fdc1bc";

class FoodDio {
  static Dio? dio;
  static init() {
    dio = Dio(BaseOptions(
      baseUrl: "https://api.spoonacular.com/recipes/complexSearch",
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData(search) async {
    {
      if(dio==null){
        init();
      }
      return await dio!.get("https://api.spoonacular.com/recipes/complexSearch?apiKey=$apiKey&addRecipeNutrition=true&query=$search");
    }

  }
}
