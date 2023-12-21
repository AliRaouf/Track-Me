import 'package:dio/dio.dart';

class ExerciseDio {

  static Dio? dio;

  static init() {
    dio = Dio(
        BaseOptions(
          baseUrl: "https://exercisedb.p.rapidapi.com", headers:
        {'X-RapidAPI-Key': 'edc2d9fb17mshbe7407180f404edp1cc63djsnb4123597d3c4',
          'X-RapidAPI-Host': 'exercisedb.p.rapidapi.com'},
          receiveDataWhenStatusError: true,
        )
    );
  }

  static Future<Response> getData(type,search) async {
    {
      if (dio == null) {
        init();
      }
      return await dio!.get("https://exercisedb.p.rapidapi.com/exercises/$type/$search");
    }
  }
}
