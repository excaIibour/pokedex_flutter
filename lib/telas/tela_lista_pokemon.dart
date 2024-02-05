import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:projeto_pokemon/stores/pokemon_store.dart';

class TelaListaPokemon extends StatefulWidget {
  final PokemonStore pokemonStore;

  const TelaListaPokemon({required this.pokemonStore, Key? key}) : super(key: key);

  @override
  TelaListaPokemonState createState() => TelaListaPokemonState();
}

class TelaListaPokemonState extends State<TelaListaPokemon> {
  @override
  void initState() {
    super.initState();
    widget.pokemonStore.listarPokemon(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PokeDex'),
      ),
      body: Observer(
        builder: (context) {
          if (widget.pokemonStore.pokemonLista.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: widget.pokemonStore.pokemonLista.length,
              itemBuilder: (context, index) {
                var pokemon = widget.pokemonStore.pokemonLista[index];
                return ListTile(
                  title: Text(pokemon.name),
                  onTap: () {
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
