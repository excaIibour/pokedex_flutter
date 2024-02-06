import 'package:dio/dio.dart';

//chamadas à pokeapi
class Requisicoes {
  static final Dio _dio = Dio();

//pega todos os pokemons
  static Future<Response> pegarListaPokemon() async {
    try {
      return await _dio.get('https://pokeapi.co/api/v2/pokemon/');
    } catch (e) {
      rethrow;
    }
  }

//pega os dados detalhados do pokemon
  static Future<Response> pegarDetalhesPokemon(String url) async {
    try {
      return await _dio.get(url);
    } catch (e) {
      rethrow;
    }
  }
}
