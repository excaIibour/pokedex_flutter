// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PokemonStore on APokemonStore, Store {
  late final _$pokemonListaAtom =
      Atom(name: 'APokemonStore.pokemonLista', context: context);

  @override
  ObservableList<Pokemon> get pokemonLista {
    _$pokemonListaAtom.reportRead();
    return super.pokemonLista;
  }

  @override
  set pokemonLista(ObservableList<Pokemon> value) {
    _$pokemonListaAtom.reportWrite(value, super.pokemonLista, () {
      super.pokemonLista = value;
    });
  }

  late final _$filtroPokemonListaAtom =
      Atom(name: 'APokemonStore.filtroPokemonLista', context: context);

  @override
  ObservableList<PokemonDetalhes> get filtroPokemonLista {
    _$filtroPokemonListaAtom.reportRead();
    return super.filtroPokemonLista;
  }

  @override
  set filtroPokemonLista(ObservableList<PokemonDetalhes> value) {
    _$filtroPokemonListaAtom.reportWrite(value, super.filtroPokemonLista, () {
      super.filtroPokemonLista = value;
    });
  }

  late final _$detalhePokemonListaAtom =
      Atom(name: 'APokemonStore.detalhePokemonLista', context: context);

  @override
  ObservableList<PokemonDetalhes> get detalhePokemonLista {
    _$detalhePokemonListaAtom.reportRead();
    return super.detalhePokemonLista;
  }

  @override
  set detalhePokemonLista(ObservableList<PokemonDetalhes> value) {
    _$detalhePokemonListaAtom.reportWrite(value, super.detalhePokemonLista, () {
      super.detalhePokemonLista = value;
    });
  }

  late final _$mapaDetalhesPokemonAtom =
      Atom(name: 'APokemonStore.mapaDetalhesPokemon', context: context);

  @override
  ObservableMap<String, PokemonDetalhes> get mapaDetalhesPokemon {
    _$mapaDetalhesPokemonAtom.reportRead();
    return super.mapaDetalhesPokemon;
  }

  @override
  set mapaDetalhesPokemon(ObservableMap<String, PokemonDetalhes> value) {
    _$mapaDetalhesPokemonAtom.reportWrite(value, super.mapaDetalhesPokemon, () {
      super.mapaDetalhesPokemon = value;
    });
  }

  late final _$listarPokemonAsyncAction =
      AsyncAction('APokemonStore.listarPokemon', context: context);

  @override
  Future<void> listarPokemon(BuildContext context) {
    return _$listarPokemonAsyncAction.run(() => super.listarPokemon(context));
  }

  late final _$APokemonStoreActionController =
      ActionController(name: 'APokemonStore', context: context);

  @override
  void filtrarPokemonsPeloNome(String nome) {
    final _$actionInfo = _$APokemonStoreActionController.startAction(
        name: 'APokemonStore.filtrarPokemonsPeloNome');
    try {
      return super.filtrarPokemonsPeloNome(nome);
    } finally {
      _$APokemonStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pokemonLista: ${pokemonLista},
filtroPokemonLista: ${filtroPokemonLista},
detalhePokemonLista: ${detalhePokemonLista},
mapaDetalhesPokemon: ${mapaDetalhesPokemon}
    ''';
  }
}
