class Pokemon {
  final String nome;
  final String url;

  Pokemon({required this.nome, required this.url});
}

class PokemonDetalhes {
  final String nome;
  final String url;
  final int baseExperience;
  final List<dynamic> habilidades;
  final String imagem;
  final int peso;
  final int altura;
  final int id;
  
  PokemonDetalhes({required this.nome, required this.url, required this.baseExperience, required this.habilidades, required this.imagem, required this.peso, required this.altura, required this.id});
}