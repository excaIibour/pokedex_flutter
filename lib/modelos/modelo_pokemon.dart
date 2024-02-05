class Pokemon {
  final String name;
  final String url;

  Pokemon({required this.name, required this.url});
}

class PokemonDetalhes {
  final String name;
  final String url;
  final int baseExperience;
  final List<dynamic> abilities;
  final String image;

  PokemonDetalhes({required this.name, required this.url, required this.baseExperience, required this.abilities, required this.image});
}