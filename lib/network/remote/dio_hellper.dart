import 'package:dio/dio.dart';

class DioHellper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type': 'application/json',
        }));
  }

  static Future<Response> GetData(
      {required String url,
      required Map<String, dynamic> query,
      String lang = 'en',
      String? token}) async {
    dio.options.headers = {'lang': lang, 'Authorization': token};
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> PostData(
      {required String url,
      Map<String, dynamic>? query,
      required Map<String, dynamic> data,
      String lang = 'en',
      String? token}) async {
    dio.options.headers = {'lang': lang, 'Authorization': token};
    return await dio.post(url, queryParameters: query, data: data);
  }
}
