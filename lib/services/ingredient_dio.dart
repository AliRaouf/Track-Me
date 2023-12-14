import 'package:dio/dio.dart';

class IngredientDio {

  static Dio? dio;

  static init() {
    dio = Dio(
        BaseOptions(
          baseUrl: "https://api.api-ninjas.com/v1", headers:
        {"x-api-key": "OCXRraZ9eDNYr73Y65yfJg==PlTZfAwyhdlYBHIs"},
          receiveDataWhenStatusError: true,
        )
    );
  }

  static Future<Response> getData({
  String? query
  }) async {
    if (dio == null) {
      init();
    }
    try {
      final response = await dio!.get("/nutrition", queryParameters: {"query": query});
      return response;
    } catch (error, stackTrace) {
      // Handle DioError and other potential exceptions here
      print('Error occurred: $error');
      // You can also log the stack trace for debugging purposes
      print('Stack trace: $stackTrace');

      // Return a custom error response or re-throw the error if needed
      return Response(requestOptions: RequestOptions(path: "/nutrition"), statusCode: 500);
    }
  }

}