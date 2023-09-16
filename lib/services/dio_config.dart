import 'package:dio/dio.dart';
import 'package:flutter_scale/main.dart';
import 'package:flutter_scale/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioConfig {
  
  static late String _token;

  static _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token') ?? '';
  }

  static final Dio _dioWithAuth = Dio()
  ..interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        await _getToken();
        options.headers['Authorization'] = 'Bearer $_token';
        options.headers['Accept'] = 'application/json';
        options.headers['Content-Type'] = 'application/json';
        options.baseUrl = baseURLAPI;
        return handler.next(options);
      },
      onResponse: (response, handler) async {
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        switch(e.response?.statusCode){
          case 400:
            logger.e('Bad Request');
            break;
          case 401:
            logger.e('Unauthorized');
            break;
          case 403:
            logger.e('Forbidden');
            break;
          case 404:
            logger.e('Not Found');
            break;
          case 500:
            logger.e('Internal Server Error');
            break;
          default:
            logger.e('Something went wrong');
            break;
        }
        return handler.next(e);
      }
    )
  );

  static final Dio _dio = Dio()
  ..interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        options.headers['Accept'] = 'application/json';
        options.headers['Content-Type'] = 'application/json';
        options.baseUrl = baseURLAPI;
        return handler.next(options);
      },
      onResponse: (response, handler) async {
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        switch(e.response?.statusCode){
          case 400:
            logger.e('Bad Request');
            break;
          case 401:
            logger.e('Unauthorized');
            break;
          case 403:
            logger.e('Forbidden');
            break;
          case 404:
            logger.e('Not Found');
            break;
          case 500:
            logger.e('Internal Server Error');
            break;
          default:
            logger.e('Something went wrong');
            break;
        }
        return handler.next(e);
      }
    )
  );

  static Dio get dioWithAuth => _dioWithAuth;
  static Dio get dio => _dio;

}