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

   @observable
  ObservableMap<String, PokemonDetalhes> mapaDetalhesPokemon = ObservableMap<String, PokemonDetalhes>();

  @action
  Future<void> listarPokemon(BuildContext context) async {
    try {
      final response = await Requisicoes.pegarListaPokemon();
      final List<Pokemon> listarPokemon = response.data['results']
          .map<Pokemon>((pokemonDados) {
            return Pokemon(
              nome: pokemonDados['name'],
              url: pokemonDados['url'],
            );
          })
          .toList();

      if (context.mounted) {
        for (var pokemon in listarPokemon) {
          await obterDetalhesPokemon(context, pokemon.url, pokemon.nome);
        }
      }

      pokemonLista = ObservableList<Pokemon>.of(listarPokemon);
      filtroPokemonLista = ObservableList<PokemonDetalhes>.of(detalhePokemonLista);
    } catch (e) {
      if (context.mounted) {
        if (e is DioException) {
          mensagem.exibirMensagem(context, 'Erro na requisição: ${e.response?.statusCode}');
        } else {
          mensagem.exibirMensagem(context, 'Algo deu errado. Tente novamente mais tarde.');
        }
      }
    }
  }

  Future<void> obterDetalhesPokemon(BuildContext context, String url, String nome) async {
    try {
      final response = await Requisicoes.pegarDetalhesPokemon(url);

      final baseExperience = response.data['base_experience'];
      final habilidades = response.data['abilities'] as List<dynamic>;
      final List<dynamic> habilidadesLista = habilidades.map<String>((habilidade) {
        final abilityData = habilidade['ability'];
        return abilityData['name'];
      }).toList();
      final imagem = response.data['sprites']['front_default'];
      final peso = response.data['weight'];
      final altura = response.data['height'];
      final id = response.data['id'];

      final PokemonDetalhes pokemon = PokemonDetalhes(
        nome: nome, 
        url: url,
        baseExperience: baseExperience,
        habilidades: habilidadesLista,
        imagem: imagem,
        peso: peso,
        altura: altura,
        id: id
      );

      detalhePokemonLista.add(pokemon);
    } catch (e) {
      if (context.mounted) {
        if (e is DioException) {
          mensagem.exibirMensagem(context, 'Erro na requisição: ${e.response?.statusCode}');
        } else {
          mensagem.exibirMensagem(context, 'Erro ao obter os detalhes. Tente novamente mais tarde.');
        }
      }
    }
  }

  @action
  void filtrarPokemonsPeloNome(String nome) {
    if (nome.isEmpty) {
      filtroPokemonLista = ObservableList<PokemonDetalhes>.of(detalhePokemonLista);
    } else {
      filtroPokemonLista = ObservableList<PokemonDetalhes>.of(detalhePokemonLista.where((pokemon) => pokemon.nome.toLowerCase().contains(nome.toLowerCase())));
    }
  }
}