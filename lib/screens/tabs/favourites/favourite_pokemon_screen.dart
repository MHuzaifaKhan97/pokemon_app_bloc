import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app_bloc/cubits/favourite_cubit/favourite_cubit.dart';
import 'package:pokemon_app_bloc/cubits/favourite_cubit/favourite_state.dart';
import 'package:pokemon_app_bloc/resources/app_theme.dart';
import 'package:pokemon_app_bloc/resources/utils.dart';
import 'package:pokemon_app_bloc/screens/tabs/favourites/favourite_pokemon_list_view.dart';
import 'package:pokemon_app_bloc/widgets/empty_widget.dart';

class FavouritePokemonScreen extends StatelessWidget {
  const FavouritePokemonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavouriteCubit, FavouriteState>(
      listener: ((context, state) {
        if (state is FavouriteErrorState) {
          Utils.snackbar(state.error, context, AppTheme.colorError);
        }
      }),
      builder: (context, state) {
        if (state is FavouriteLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is FavouriteLoadedState) {
          return FavouritePokemonListView(pokemons: state.favouritePokemons);
        } else if (state is FavouriteEmptyListState) {
          return const EmptyWidget();
        }
        return const Center(
          child: Text("An Error has occured"),
        );
      },
    );
  }
}
