import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:projeto_pokemon/modelos/modelo_pokemon.dart';
import 'package:projeto_pokemon/stores/pokemon_store.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TelaListaPokemon extends StatefulWidget {
  final PokemonStore pokemonStore;

  const TelaListaPokemon({required this.pokemonStore, Key? key}) : super(key: key);

  @override
  TelaListaPokemonState createState() => TelaListaPokemonState();
}

class TelaListaPokemonState extends State<TelaListaPokemon> {
  bool ehEscuro = false;
  TextEditingController pesquisaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.pokemonStore.listarPokemon(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ehEscuro ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Pokedex'),
          actions: [
            IconButton(
              icon: const Icon(Icons.lightbulb),
              onPressed: () {
                setState(() {
                  ehEscuro = !ehEscuro;
                });
              },
            ),
          ],
        ),
        body: Observer(
          builder: (context) {
            if (widget.pokemonStore.pokemonLista.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                  _barraPesquisa(),
                  _listaCardPokemon(),
                ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _barraPesquisa() {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 50, bottom: 20, top: 20),
      child: TextField(
        controller: pesquisaController,
        onChanged: (value) {
          widget.pokemonStore.filtrarPokemonsPeloNome(value);
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(color: Colors.grey, width: 0.5),
          ),
          hintText: 'Pesquisar Pokémon',
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _listaCardPokemon() {
    return Center(
      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: widget.pokemonStore.filtroPokemonLista
            .map((pokemon) => _cardPokemon(pokemon, context))
            .toList(),
      ),
    );
  }

  Widget _cardPokemon(PokemonDetalhes pokemonDetalhes, BuildContext context) {
    return GestureDetector(
      onTap: () {
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CachedNetworkImage(
                imageUrl: pokemonDetalhes.image,
                width: 230.0,
                height: 150.0,
                placeholder: (context, image) => const CircularProgressIndicator(),
                errorWidget: (context, image, error) => const Icon(Icons.error),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  pokemonDetalhes.name,
                  style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Clique para visualizar mais',
                  style: TextStyle(fontSize: 12.0, color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
