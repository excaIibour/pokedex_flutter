import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:projeto_pokemon/modelos/modelo_pokemon.dart';
import 'package:projeto_pokemon/stores/pokemon_store.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:projeto_pokemon/tema/tema.dart';

class TelaListaPokemon extends StatefulWidget {
  final PokemonStore pokemonStore;

  const TelaListaPokemon({required this.pokemonStore, Key? key}) : super(key: key);

  @override
  TelaListaPokemonState createState() => TelaListaPokemonState();
}

class TelaListaPokemonState extends State<TelaListaPokemon> {
  TextEditingController pesquisaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.pokemonStore.listarPokemon(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Tema.cores.primary,
          toolbarHeight: 100,
          title: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Pokédex',
              style: TextStyle(fontFamily: 'Blinker', fontWeight: FontWeight.bold, fontSize: 35, color: Tema.cores.secondary),
            ),
          ),
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
      padding: const EdgeInsets.only(left: 35, right: 35, bottom: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Text('Pesquise um Pokemon pelo nome.', style: TextStyle(color: Colors.grey)),
          ),
          TextField(
            controller: pesquisaController,
            onChanged: (value) {
              widget.pokemonStore.filtrarPokemonsPeloNome(value);
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
              hintText: 'Nome',
              hintStyle: const TextStyle(color: Colors.grey),
              prefixIcon: Icon(Icons.search, color: Tema.cores.secondary),
            ),
          ),
        ]
      )
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
    int index = widget.pokemonStore.filtroPokemonLista.indexOf(pokemonDetalhes);
    Color corCard = _agruparPokemons(index);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/detalhes',
          arguments: pokemonDetalhes,
        );
      },
      child: Card(
        color: corCard,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CachedNetworkImage(
                imageUrl: pokemonDetalhes.imagem,
                width: 120.0,
                height: 120.0,
                fit: BoxFit.cover,
                placeholder: (context, image) => const CircularProgressIndicator(),
                errorWidget: (context, image, error) => const Icon(Icons.error),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  pokemonDetalhes.nome,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Tema.cores.secondary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _agruparPokemons(int index) {
    int pokemonsPorGrupo = 3;
    List<Color> cores = [const Color(0xFFCAE2D5), const Color(0xFFEAD4BC), const Color(0xFF9CCEDD)];

    int grupoIndex = (index ~/ pokemonsPorGrupo) % cores.length;

    return cores[grupoIndex];
  }
}
