import 'package:dio/dio.dart';

String apiKey="67dbf1f8abf44194a1c0281cf9fdc1bc";

class FoodDio {
  static Dio? dio;
  static init() {
    dio = Dio(BaseOptions(
      baseUrl: "https://api.spoonacular.com",
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData(search,type) async {
    {
      if(dio==null){
        init();
      }
      return await dio!.get("https://api.spoonacular.com$type?apiKey=$apiKey&addRecipeNutrition=true&query=$search");
    }

  }
}
