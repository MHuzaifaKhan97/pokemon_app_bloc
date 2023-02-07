import 'package:pokemon_app_bloc/data/models/pokemon_model.dart';

abstract class PokemonState {}

class PokemonLoadingState extends PokemonState {}

class PokemonLoadedState extends PokemonState {
  final List<PokemonModel> pokemons;
  PokemonLoadedState(this.pokemons);
}

class PokemonErrorState extends PokemonState {
  final String error;
  PokemonErrorState(this.error);
}

class PokemonAddFavouriteState extends PokemonState {
  final String message;
  PokemonAddFavouriteState(this.message);
}
