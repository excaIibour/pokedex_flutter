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

  late final _$listarPokemonAsyncAction =
      AsyncAction('APokemonStore.listarPokemon', context: context);

  @override
  Future<void> listarPokemon(BuildContext context) {
    return _$listarPokemonAsyncAction.run(() => super.listarPokemon(context));
  }

  @override
  String toString() {
    return '''
pokemonLista: ${pokemonLista}
    ''';
  }
}
