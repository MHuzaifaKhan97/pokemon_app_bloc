import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app_bloc/cubits/auth_cubit/auth_cubit.dart';
import 'package:pokemon_app_bloc/cubits/favourite_cubit/favourite_cubit.dart';
import 'package:pokemon_app_bloc/cubits/favourite_cubit/favourite_state.dart';
import 'package:pokemon_app_bloc/data/models/pokemon_model.dart';
import 'package:pokemon_app_bloc/resources/app_theme.dart';
import 'package:pokemon_app_bloc/resources/utils.dart';
import 'package:pokemon_app_bloc/widgets/pokemon_view_widget.dart';

class FavouritePokemonListView extends StatelessWidget {
  FavouritePokemonListView({Key? key, required this.pokemons})
      : super(key: key);
  List<PokemonModel> pokemons;
  @override
  Widget build(BuildContext context) {
    return BlocListener<FavouriteCubit, FavouriteState>(
      listener: (context, state) {
        if (state is FavouriteRemovedFavouriteState) {
          Utils.snackbar(state.message, context, AppTheme.colorSuccess);
        }
      },
      child: ListView.builder(
        itemCount: pokemons.length,
        itemBuilder: (context, index) {
          PokemonModel pokemon = pokemons[index];
          return PokemonViewWidget(
            icon: Icons.remove_circle_outline,
            pokemon: pokemon,
            onPressed: () {
              var uid = BlocProvider.of<AuthCubit>(context).currentUser!.uid;
              BlocProvider.of<FavouriteCubit>(context)
                  .removeFavouritePokemon(pokemon, uid);
            },
          );
        },
      ),
    );
  }
}
