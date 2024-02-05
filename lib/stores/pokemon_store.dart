import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:projeto_pokemon/modelos/modelo_pokemon.dart';
import 'package:projeto_pokemon/servicos/mensagem.dart';
import 'package:projeto_pokemon/servicos/servico_api.dart';

part 'pokemon_store.g.dart';

class PokemonStore = APokemonStore with _$PokemonStore;

abstract class APokemonStore with Store {
  Mensagem mensagem = Mensagem();

  @observable
  ObservableList<Pokemon> pokemonLista = ObservableList<Pokemon>();

  @observable
  ObservableList<PokemonDetalhes> filtroPokemonLista = ObservableList<PokemonDetalhes>();

  @observable
  ObservableList<PokemonDetalhes> detalhePokemonLista = ObservableList<PokemonDetalhes>();

  @action
  Future<void> listarPokemon(BuildContext context) async {
    try {
      final response = await Requisicoes.pegarListaPokemon();
      final List<Pokemon> listarPokemon = response.data['results']
          .map<Pokemon>((pokemonDados) {
            return Pokemon(
              name: pokemonDados['name'],
              url: pokemonDados['url'],
            );
          })
          .toList();

      for (var pokemon in listarPokemon) {
        await obterDetalhesPokemon(pokemon.url, pokemon.name);
      }

      pokemonLista = ObservableList<Pokemon>.of(listarPokemon);
      filtroPokemonLista = ObservableList<PokemonDetalhes>.of(detalhePokemonLista);
    } catch (e) {
      if (context.mounted) {
        if (e is DioException && e.response != null) {
          mensagem.exibirMensagem(context, 'Erro na requisição: ${e.response?.statusCode}');
        } else {
          mensagem.exibirMensagem(context, 'Algo deu errado. Tente novamente mais tarde.');
        }
      }
    }
  }

  Future<void> obterDetalhesPokemon(String url, String name) async {
    try {
      final response = await Requisicoes.pegarDetalhesPokemon(url);

      final baseExperience = response.data['base_experience'];
      final abilities = response.data['abilities'];
      final image = response.data['sprites']['front_default'];

      final PokemonDetalhes pokemon = PokemonDetalhes(
        name: name, 
        url: url,
        baseExperience: baseExperience,
        abilities: abilities,
        image: image
      );

      detalhePokemonLista.add(pokemon);
    } catch (e) {
      //print('Erro ao obter detalhes do Pokemon: $e');
    }
  }

  @action
  void filtrarPokemonsPeloNome(String name) {
    if (name.isEmpty) {
      filtroPokemonLista = ObservableList<PokemonDetalhes>.of(detalhePokemonLista);
    } else {
      filtroPokemonLista = ObservableList<PokemonDetalhes>.of(detalhePokemonLista.where((pokemon) => pokemon.name.toLowerCase().contains(name.toLowerCase())));
    }
  }
}