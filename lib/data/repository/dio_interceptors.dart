import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('📲📲 DIO-REQUEST[${options.method}] => PATH: ${options.path}');
    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(Response response, ResponseInterceptorHandler handler) async {
    debugPrint('🐝🐝 DIO-RESPONSE[statusCode: ${response.statusCode}] => PATH: ${response.requestOptions.path}');
    debugPrint('🐝🐝 DIO-RESPONSE[reqeustData: ${response.requestOptions.data}]');
    debugPrint('🐝🐝 DIO-RESPONSE[data: ${response.data}]');
    debugPrint('🐝🐝 DIO-RESPONSE[extra: ${response.extra}]');
    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    debugPrint('🐞🐞 DIO-ERROR[statusCode: ${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    debugPrint('🐞🐞 DIO-ERROR[requestData: ${err.requestOptions.data}]');
    debugPrint('🐞🐞 DIO-ERROR[data: ${err.response?.data}]');
    debugPrint('🐞🐞 DIO-ERROR[extra: ${err.response?.extra}]');
    return super.onError(err, handler);
  }
}
