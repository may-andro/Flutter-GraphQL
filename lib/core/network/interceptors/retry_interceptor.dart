import 'package:dio/dio.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {}
}
