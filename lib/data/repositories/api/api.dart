import 'package:dio/dio.dart';

class API {
  Dio _dio = Dio();
  API() {
    _dio.options.baseUrl = "https://pokeapi.co/api/v2";
  }
  Dio get sendRequest => _dio;
}
