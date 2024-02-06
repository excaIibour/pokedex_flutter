import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:projeto_pokemon/modelos/modelo_pokemon.dart';
import 'package:projeto_pokemon/servicos/mensagem.dart';
import 'package:projeto_pokemon/servicos/servico_api.dart';

part 'pokemon_store.g.dart';

class PokemonStore = APokemonStore with _$PokemonStore;

abstract class APokemonStore with Store {
//objeto pra exibir mensagens de erro
  Mensagem mensagem = Mensagem();

//lista observavel de pokemons
  @observable
  ObservableList<Pokemon> pokemonLista = ObservableList<Pokemon>();

//lista observavel de pokemons para filtragem atraves do nome
  @observable
  ObservableList<PokemonDetalhes> filtroPokemonLista = ObservableList<PokemonDetalhes>();

//lista observavel de detalhes dos pokemons
  @observable
  ObservableList<PokemonDetalhes> detalhePokemonLista = ObservableList<PokemonDetalhes>();

//metodo de ação assíncrona para listar pokemons
  @action
  Future<void> listarPokemon(BuildContext context) async {
    try {
      //realiza a requisição para obter a lista
      final response = await Requisicoes.pegarListaPokemon();
      //mapeia os dados da resposta
      final List<Pokemon> listarPokemon = response.data['results']
          .map<Pokemon>((pokemonDados) {
            return Pokemon(
              nome: pokemonDados['name'],
              url: pokemonDados['url'],
            );
          })
          .toList();

      //se a tela ainda estiver 'montada' (ativa), obtem os detalhes pra cada pokemon e adiciona na lista de detalhes
      if (context.mounted) {
        for (var pokemon in listarPokemon) {
          await obterDetalhesPokemon(context, pokemon.url, pokemon.nome);
        }
      }

      //atualiza as listas observáveis com as listas criadas

      pokemonLista = ObservableList<Pokemon>.of(listarPokemon);
      filtroPokemonLista = ObservableList<PokemonDetalhes>.of(detalhePokemonLista);
    } catch (e) {
      //trata erros durante a requisição caso a tela ainda esteja 'montada' (ativa)
      if (context.mounted) {
        if (e is DioException) {
          mensagem.exibirMensagem(context, 'Erro na requisição: ${e.response?.statusCode}');
        } else {
          mensagem.exibirMensagem(context, 'Algo deu errado. Tente novamente mais tarde.');
        }
      }
    }
  }

  //método de ação assíncrona para obter detalhes de um pokemon
  Future<void> obterDetalhesPokemon(BuildContext context, String url, String nome) async {
    try {
      //faz a requisição para obter detalhes do pokemon
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

      //atribui PokemonDetalhes com os detalhes obtidos
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

      //adiciona o objeto PokemonDetalhes à lista detalhePokemonLista
      detalhePokemonLista.add(pokemon);
    } catch (e) {
      //trata erros durante a requisição caso a tela ainda esteja 'montada' (ativa)
      if (context.mounted) {
        if (e is DioException) {
          mensagem.exibirMensagem(context, 'Erro na requisição: ${e.response?.statusCode}');
        } else {
          mensagem.exibirMensagem(context, 'Erro ao obter os detalhes. Tente novamente mais tarde.');
        }
      }
    }
  }

  //metodo de ação para filtrar pokemon pelo nome
  @action
  void filtrarPokemonsPeloNome(String nome) {
    if (nome.isEmpty) {
      filtroPokemonLista = ObservableList<PokemonDetalhes>.of(detalhePokemonLista);
    } else {
      filtroPokemonLista = ObservableList<PokemonDetalhes>.of(detalhePokemonLista.where((pokemon) => pokemon.nome.toLowerCase().contains(nome.toLowerCase())));
    }
  }
}