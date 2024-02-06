import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:projeto_pokemon/modelos/modelo_pokemon.dart';
import 'package:projeto_pokemon/tema/tema.dart';

class TelaDetalhesPokemon extends StatefulWidget {
  const TelaDetalhesPokemon({Key? key}) : super(key: key);

  @override
  TelaDetalhesPokemonState createState() => TelaDetalhesPokemonState();
}

class TelaDetalhesPokemonState extends State<TelaDetalhesPokemon> {
  late PageController _secaoController;
  int _secaoAtual = 0;

  @override
  void initState() {
    super.initState();
    _secaoController = PageController(initialPage: _secaoAtual);
  }

  @override
  void dispose() {
    _secaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PokemonDetalhes? pokemonDetalhes = ModalRoute.of(context)!.settings.arguments as PokemonDetalhes?;

    if (pokemonDetalhes == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Erros acontecem!'),
        ),
        body: const Center(
          child: Padding(
          padding: EdgeInsets.only(left: 40.0, right: 40.0),
            child: Text(
              'Oops, algo deu errado ao exibir os detalhes do Pokémon. Atualize a pagina ou entre novamente.',
              style: TextStyle(fontSize: 18, color: Colors.red),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        title: Text(pokemonDetalhes.nome, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Tema.cores.secondary)),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(left: 40.0, right: 40.0),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    color: const Color(0xFFD8E4E9),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CircleAvatar(
                            radius: 25.0,
                            backgroundColor: Tema.cores.secondary,
                            child: Text(
                              '${pokemonDetalhes.id}',
                              style: const TextStyle(fontSize: 15.0, color: Colors.white),
                            ),
                          ),
                          CachedNetworkImage(
                            imageUrl: pokemonDetalhes.imagem,
                            width: 300.0,
                            height: 300.0,
                            fit: BoxFit.cover,
                            placeholder: (context, image) => const CircularProgressIndicator(),
                            errorWidget: (context, image, error) => const Icon(Icons.error),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text('Detalhes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Tema.cores.secondary)),
                  _secao(pokemonDetalhes),
                  _secaoBotoes(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _secao(PokemonDetalhes pokemonDetalhes) {
    return SizedBox(
      height: 40.0,
      child: PageView(
        controller: _secaoController,
        onPageChanged: (index) {
          setState(() {
            _secaoAtual = index;
          });
        },
        children: [
          _secaoTexto('Base Experience: ${pokemonDetalhes.baseExperience}'),
          _secaoTexto('Habilidades: ${pokemonDetalhes.habilidades.join(', ')}'),
          _secaoTexto('Peso: ${pokemonDetalhes.peso}'),
          _secaoTexto('Altura: ${pokemonDetalhes.altura}'),
        ],
      ),
    );
  }

  Widget _secaoBotoes() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Tema.cores.secondary,
          onPressed: () {
            if (_secaoAtual > 0) {
              _secaoController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
            }
          },
        ),
        const SizedBox(width: 16.0),
        IconButton(
          icon: const Icon(Icons.arrow_forward),
          color: Tema.cores.secondary,
          onPressed: () {
            if (_secaoAtual < 4 - 1) {
              _secaoController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
            }
          },
        ),
      ],
    );
  }

  Widget _secaoTexto(String content) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          content,
          style: TextStyle(fontSize: 18, color: Tema.cores.secondary),
        ),
      ),
    );
  }
}