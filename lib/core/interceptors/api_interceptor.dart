import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor{
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.connectTimeout = const Duration(seconds: 20);
    options.receiveTimeout = const Duration(seconds: 30);
    super.onRequest(options, handler);
  }
}