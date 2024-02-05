// main.dart
import 'package:flutter/material.dart';
import 'package:projeto_pokemon/telas/tela_lista_pokemon.dart';
import 'package:projeto_pokemon/stores/pokemon_store.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final PokemonStore _pokemonStore = PokemonStore();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PokeDex',
      home: TelaListaPokemon(pokemonStore: _pokemonStore),
    );
  }
}
