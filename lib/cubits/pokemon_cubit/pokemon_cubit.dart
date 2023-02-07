import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app_bloc/data/models/pokemon_model.dart';
import 'package:pokemon_app_bloc/data/repositories/pokemon_repository.dart';
import 'package:pokemon_app_bloc/cubits/pokemon_cubit/pokemon_state.dart';

class PokemonCubit extends Cubit<PokemonState> {
  PokemonCubit() : super(PokemonLoadingState()) {
    fetchPokemon();
  }
  // Pokemon Repository
  final PokemonRepository _pokemonRepository = PokemonRepository();

  // Fetch pokemon from api
  void fetchPokemon() async {
    try {
      List<PokemonModel> pokemons = await _pokemonRepository.fetchPokemon();
      emit(PokemonLoadedState(pokemons));
    } on DioError catch (e) {
      if (e.type == DioErrorType.other) {
        emit(PokemonErrorState(
            "Can't fetch data, please check your internet conenction!"));
      } else {
        emit(PokemonErrorState(e.message.toString()));
      }
    }
  }

  // Convert text to capitalized
  String toCapitalized(String value) {
    return value[0].toUpperCase() + value.substring(1);
  }
}
