import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app_bloc/data/models/pokemon_model.dart';
import 'package:pokemon_app_bloc/cubits/favourite_cubit/favourite_state.dart';
import 'package:pokemon_app_bloc/resources/global_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(FavouriteLoadingState()) {
    getFavouritePokemons();
  }
  // Firebase Auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // SharedPreferences
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  // Get Favourite Pokemons
  getFavouritePokemons() async {
    final SharedPreferences prefs = await _prefs;
    var encodedData = prefs.getString(GlobalConstants.FAVOURITES);
    if (encodedData != null) {
      List<dynamic> decodedData = jsonDecode(encodedData);
      List<PokemonModel> pokemons = decodedData
          .map((pokemonObj) => PokemonModel.fromJson(pokemonObj))
          .toList();
      List<PokemonModel> filteredPokemon = pokemons
          .where((pokemon) => pokemon.uid == _auth.currentUser!.uid)
          .toList();
      if (filteredPokemon.isEmpty) {
        emit(FavouriteEmptyListState());
      } else {
        emit(FavouriteLoadedState(filteredPokemon));
      }
    } else {
      emit(FavouriteEmptyListState());
    }
  }

  // Add Favourite Pokemons
  addFavouritePokemon(PokemonModel pokemon, String uid) async {
    final SharedPreferences prefs = await _prefs;
    var encodedData = prefs.getString(GlobalConstants.FAVOURITES);
    List<PokemonModel> pokemons = <PokemonModel>[];
    if (encodedData != null) {
      List<dynamic> decodedData = jsonDecode(encodedData);
      pokemons = decodedData
          .map((pokemonObj) => PokemonModel.fromJson(pokemonObj))
          .toList();
    } else {
      pokemons = <PokemonModel>[];
    }
    pokemon.uid = uid;
    if (pokemons.isNotEmpty) {
      var res = pokemons.where((el) => el.uid == uid && el.url == pokemon.url);
      if (res.isNotEmpty) {
        emit(FavouriteAlreadyExistsState("Favourite already exists"));
        return;
      }
    }
    pokemons.add(pokemon);

    String encodedList = jsonEncode(pokemons);
    prefs.setString(GlobalConstants.FAVOURITES, encodedList);
    emit(FavouriteAddFavouriteState("Successfully added to favorites"));
    getFavouritePokemons();
  }

// Remove Favourite Pokemons
  removeFavouritePokemon(PokemonModel pokemon, String uid) async {
    final SharedPreferences prefs = await _prefs;
    var encodedData = prefs.getString(GlobalConstants.FAVOURITES);
    List<PokemonModel> pokemons = <PokemonModel>[];
    if (encodedData != null) {
      List<dynamic> decodedData = jsonDecode(encodedData);
      pokemons = decodedData
          .map((pokemonObj) => PokemonModel.fromJson(pokemonObj))
          .toList();
    } else {
      pokemons = <PokemonModel>[];
    }
    pokemon.uid = uid;
    if (pokemons.isNotEmpty) {
      pokemons.removeWhere((el) => el.uid == uid && el.url == pokemon.url);
    }
    String encodedList = jsonEncode(pokemons);
    prefs.setString(GlobalConstants.FAVOURITES, encodedList);
    emit(FavouriteRemovedFavouriteState("Successfully removed from favorites"));
    getFavouritePokemons();
  }
}
