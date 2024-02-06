import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:projeto_pokemon/modelos/modelo_pokemon.dart';
import 'package:projeto_pokemon/tema/tema.dart';

class TelaDetalhesPokemon extends StatelessWidget {
  const TelaDetalhesPokemon({super.key});

  @override
  Widget build(BuildContext context) {
    final PokemonDetalhes pokemonDetalhes = ModalRoute.of(context)!.settings.arguments as PokemonDetalhes;

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
          child: Column( 
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card( 
                color: const Color(0xFFD8E4E9),
                child: Padding(
                padding: const EdgeInsets.all(10.0),
                  child: CachedNetworkImage(
                    imageUrl: pokemonDetalhes.imagem,
                    width: 400.0,
                    height: 350.0,
                    fit: BoxFit.cover,
                    placeholder: (context, image) => const CircularProgressIndicator(),
                    errorWidget: (context, image, error) => const Icon(Icons.error),
                  ),
                )
              ),
              const SizedBox(height: 12.0),
              Text('Detalhes:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Tema.cores.secondary)),
              const SizedBox(height: 10.0),
              Text('Base Experience: ${pokemonDetalhes.baseExperience}', style: TextStyle(fontSize: 18, color: Tema.cores.secondary)),
              const SizedBox(height: 5.0),
              Text('Habilidades: ${pokemonDetalhes.habilidades.join(', ')}', style: TextStyle(fontSize: 18, color: Tema.cores.secondary)),
              const SizedBox(height: 5.0),
              Text('Peso: ${pokemonDetalhes.peso}', style: TextStyle(fontSize: 18, color: Tema.cores.secondary)),
              const SizedBox(height: 5.0),
              Text('Altura: ${pokemonDetalhes.altura}', style: TextStyle(fontSize: 18, color: Tema.cores.secondary)),
            ]
          )
        ),
      ),
    );
  }
}