import 'package:flutter/material.dart';
import 'package:projeto_pokemon/telas/tela_detalhes_pokemon.dart';
import 'package:projeto_pokemon/telas/tela_lista_pokemon.dart';
import 'package:projeto_pokemon/stores/pokemon_store.dart';
import 'package:projeto_pokemon/tema/tema.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final PokemonStore _pokemonStore = PokemonStore();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PokeDex',
      theme: Tema.tema,
      initialRoute: '/',
      routes: {
        '/': (context) => TelaListaPokemon(pokemonStore: _pokemonStore),
        '/detalhes': (context) => const TelaDetalhesPokemon(),
      },
    );
  }
}
