import 'package:pokemon_app_bloc/data/models/pokemon_model.dart';

abstract class FavouriteState {}

class FavouriteLoadingState extends FavouriteState {}

class FavouriteLoadedState extends FavouriteState {
  final List<PokemonModel> favouritePokemons;
  FavouriteLoadedState(this.favouritePokemons);
}

class FavouriteErrorState extends FavouriteState {
  final String error;
  FavouriteErrorState(this.error);
}

class FavouriteAddFavouriteState extends FavouriteState {
  final String message;
  FavouriteAddFavouriteState(this.message);
}

class FavouriteRemovedFavouriteState extends FavouriteState {
  final String message;
  FavouriteRemovedFavouriteState(this.message);
}

class FavouriteEmptyListState extends FavouriteState {}
