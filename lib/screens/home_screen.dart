import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app_bloc/data/models/pokemon_model.dart';
import 'package:pokemon_app_bloc/logic/cubits/auth_cubit/auth_cubit.dart';
import 'package:pokemon_app_bloc/logic/cubits/auth_cubit/auth_state.dart';
import 'package:pokemon_app_bloc/logic/cubits/favourite_cubit/favourite_cubit.dart';
import 'package:pokemon_app_bloc/logic/cubits/favourite_cubit/favourite_state.dart';
import 'package:pokemon_app_bloc/logic/cubits/pokemon_cubit/pokemon_cubit.dart';
import 'package:pokemon_app_bloc/logic/cubits/pokemon_cubit/pokemon_state.dart';
import 'package:pokemon_app_bloc/screens/login_screen.dart';
import 'package:pokemon_app_bloc/widgets/logo_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: LogoWidget(
              textSize: 20,
              iconSize: MediaQuery.of(context).size.width * 0.1,
            ),
            toolbarHeight: MediaQuery.of(context).size.height * 0.08,
            bottom: const TabBar(
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              tabs: [
                Tab(
                  text: "ALL POKEMONS",
                ),
                Tab(
                  text: "FAVOURITES",
                ),
              ],
            ),
            actions: [
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthLoggedOutState) {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: ((context) => const LoginScreen())));
                  }
                },
                builder: (context, state) {
                  return IconButton(
                      onPressed: () {
                        BlocProvider.of<AuthCubit>(context).loggedOut();
                      },
                      icon: const Icon(Icons.logout));
                },
              ),
            ],
          ),
          body: const TabBarView(children: [
            AllPokemonScreen(),
            FavouritePokemonScreen(),
          ])),
    );
  }
}

class AllPokemonScreen extends StatelessWidget {
  const AllPokemonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PokemonCubit, PokemonState>(
      listener: ((context, state) {
        if (state is PokemonErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red, content: Text(state.error)));
        }
      }),
      builder: (context, state) {
        if (state is PokemonLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PokemonLoadedState) {
          return pokemonListView(state.pokemons);
        }
        return const Center(
          child: Text("An Error has occured"),
        );
      },
    );
  }

  Widget pokemonListView(List<PokemonModel> pokemons) {
    return BlocListener<FavouriteCubit, FavouriteState>(
      listener: (context, state) {
        if (state is FavouriteAddFavouriteState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green, content: Text(state.message)));
        }
      },
      child: ListView.builder(
        itemCount: pokemons.length,
        itemBuilder: (context, index) {
          PokemonModel pokemon = pokemons[index];
          return Container(
            height: MediaQuery.of(context).size.height * 0.10,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  )
                ],
                color: const Color(0xFF1e81b0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        BlocProvider.of<PokemonCubit>(context)
                            .toCapitalized(pokemon.name!),
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        pokemon.url!,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () {
                      var uid =
                          BlocProvider.of<AuthCubit>(context).currentUser!.uid;
                      BlocProvider.of<FavouriteCubit>(context)
                          .addFavouritePokemon(pokemon, uid);
                    },
                    icon: const Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    )),
              ],
            ),
          );
        },
      ),
    );
  }
}

class FavouritePokemonScreen extends StatelessWidget {
  const FavouritePokemonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavouriteCubit, FavouriteState>(
      listener: ((context, state) {
        if (state is FavouriteErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red, content: Text(state.error)));
        }
      }),
      builder: (context, state) {
        if (state is FavouriteLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is FavouriteLoadedState) {
          return pokemonListView(state.favouritePokemons);
        } else if (state is FavouriteEmptyListState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "./assets/empty.png",
                  width: 40,
                  color: const Color(0xFF1e81b0),
                ),
                const SizedBox(height: 6),
                const Text(
                  "No favourite added yet",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF1e81b0),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          );
        }
        return const Center(
          child: Text("An Error has occured"),
        );
      },
    );
  }

  Widget pokemonListView(List<PokemonModel> pokemons) {
    return ListView.builder(
      itemCount: pokemons.length,
      itemBuilder: (context, index) {
        PokemonModel pokemon = pokemons[index];
        return Container(
          height: MediaQuery.of(context).size.height * 0.10,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                )
              ],
              color: const Color(0xFF1e81b0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      BlocProvider.of<PokemonCubit>(context)
                          .toCapitalized(pokemon.name!),
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      pokemon.url!,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                  ))
            ],
          ),
        );
      },
    );
  }
}
