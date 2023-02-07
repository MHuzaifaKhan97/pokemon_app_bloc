import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app_bloc/cubits/pokemon_cubit/pokemon_cubit.dart';
import 'package:pokemon_app_bloc/cubits/pokemon_cubit/pokemon_state.dart';
import 'package:pokemon_app_bloc/resources/app_theme.dart';
import 'package:pokemon_app_bloc/resources/utils.dart';
import 'package:pokemon_app_bloc/screens/tabs/all_pokemons/pokemon_list_view.dart';

class AllPokemonScreen extends StatelessWidget {
  const AllPokemonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PokemonCubit, PokemonState>(
      listener: ((context, state) {
        if (state is PokemonErrorState) {
          Utils.snackbar(state.error, context, AppTheme.colorError);
        }
      }),
      builder: (context, state) {
        if (state is PokemonLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PokemonLoadedState) {
          return PokemonListView(
            pokemons: state.pokemons,
          );
        }
        return const Center(
          child: Text("An Error has occured"),
        );
      },
    );
  }
}
