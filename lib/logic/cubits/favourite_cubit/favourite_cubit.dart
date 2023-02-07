import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app_bloc/data/models/pokemon_model.dart';
import 'package:pokemon_app_bloc/logic/cubits/favourite_cubit/favourite_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(FavouriteLoadingState()) {
    getFavouritePokemons();
  }
  // Firebase Auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  getFavouritePokemons() async {
    final SharedPreferences prefs = await _prefs;
    var encodedData = prefs.getString("favourites");
    if (encodedData != null) {
      List<dynamic> decodedData = jsonDecode(encodedData);
      List<PokemonModel> pokemons =
          decodedData.map((post) => PokemonModel.fromJson(post)).toList();
      List<PokemonModel> filteredPokemon = pokemons
          .where((pokemon) => pokemon.uid == _auth.currentUser!.uid)
          .toList();
      if (filteredPokemon.isEmpty) {
        emit(FavouriteEmptyListState());
      } else {
        emit(FavouriteLoadedState(filteredPokemon));
      }
      // return filteredPokemon;
    } else {
      emit(FavouriteEmptyListState());
    }
  }

  addFavouritePokemon(PokemonModel pokemon, String uid) async {
    final SharedPreferences prefs = await _prefs;
    var encodedData = prefs.getString("favourites");
    List<PokemonModel> pokemons = <PokemonModel>[];
    if (encodedData != null) {
      List<dynamic> decodedData = jsonDecode(encodedData);
      pokemons =
          decodedData.map((post) => PokemonModel.fromJson(post)).toList();
    } else {
      pokemons = <PokemonModel>[];
    }
    pokemon.uid = uid;
    pokemons.add(pokemon);
    String encodedList = jsonEncode(pokemons);
    prefs.setString("favourites", encodedList);
    emit(FavouriteAddFavouriteState("successfully added to favorites"));
    getFavouritePokemons();
  }

  // String toCapitalized(String value) {
  //   return value[0].toUpperCase() + value.substring(1);
  // }
}
