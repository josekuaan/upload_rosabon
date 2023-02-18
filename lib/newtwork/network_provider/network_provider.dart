import 'package:dio/dio.dart';
import 'package:rosabon/newtwork/api_error.dart';
import 'package:rosabon/newtwork/interceptor/app_interceptor.dart';

class NetworkProvider {
  Dio _getDioInstance() {
    var dio = Dio(BaseOptions(connectTimeout: 30000, receiveTimeout: 30000,receiveDataWhenStatusError: true));
    dio.interceptors.add(AppInterceptors());
    dio.interceptors.add(LogInterceptor(
        responseBody: true, error: true, request: true, requestBody: true));

    return dio;
  }

  Future<Response?> call(
      {required String path,
      required RequestMethod method,
      dynamic body = const {},
      Map<String, dynamic> queryParams = const {}}) async {
    Response? response;
    try {
      switch (method) {
        case RequestMethod.get:
          response =
              await _getDioInstance().get(path, queryParameters: queryParams);
          break;
        case RequestMethod.post:
          response = await _getDioInstance()
              .post(path, data: body, queryParameters: queryParams);
          break;
        case RequestMethod.patch:
          response = await _getDioInstance()
              .patch(path, data: body, queryParameters: queryParams);
          break;
        case RequestMethod.put:
          response = await _getDioInstance()
              .put(path, data: body, queryParameters: queryParams);
          break;
        case RequestMethod.delete:
          response = await _getDioInstance()
              .delete(path, data: body, queryParameters: queryParams);
          break;
      }

      return response;
    } on DioError catch (e) {
      if (e.response!.statusCode == 428) {
        return e.response;
      }

      return Future.error(ApiError.fromDio(e));
    }
  }
}

enum RequestMethod { get, post, put, patch, delete }
