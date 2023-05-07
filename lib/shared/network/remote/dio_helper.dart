import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://homination.onrender.com/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData({
    required String url,
    required Map<String, dynamic> query,
  }) async {
    print(query);
    return await dio!.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
  }) async {
    print(data);

    if (dio == null) {
      // Handle the case where dio is null, e.g. by throwing an exception
      throw Exception('dio is null');
    }

    return dio!.post(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
