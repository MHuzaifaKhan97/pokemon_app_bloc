import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app_bloc/data/models/pokemon_model.dart';
import 'package:pokemon_app_bloc/data/repositories/pokemon_repository.dart';
import 'package:pokemon_app_bloc/logic/cubits/pokemon_cubit/pokemon_state.dart';

class PokemonCubit extends Cubit<PokemonState> {
  PokemonCubit() : super(PokemonLoadingState()) {
    fetchPosts();
  }
  final PokemonRepository _pokemonRepository = PokemonRepository();

  void fetchPosts() async {
    try {
      List<PokemonModel> pokemons = await _pokemonRepository.fetchPokemon();
      emit(PokemonLoadedState(pokemons));
    } on DioError catch (e) {
      if (e.type == DioErrorType.other) {
        emit(PokemonErrorState(
            "Can't fetch posts, please check your internet conenction!"));
      } else {
        emit(PokemonErrorState(e.message.toString()));
      }
    }
  }

  String toCapitalized(String value) {
    return value[0].toUpperCase() + value.substring(1);
  }
}
