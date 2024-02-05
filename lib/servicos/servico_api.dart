// api_services.dart
import 'package:dio/dio.dart';

class Requisicoes {
  static final Dio _dio = Dio();

  static Future<Response> pegarListaPokemon() async {
    try {
      return await _dio.get('https://pokeapi.co/api/v2/pokemon/');
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response> pegarDetalhesPokemon(String url) async {
    try {
      return await _dio.get(url);
    } catch (e) {
      rethrow;
    }
  }
}
