import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app_bloc/cubits/auth_cubit/auth_cubit.dart';
import 'package:pokemon_app_bloc/cubits/auth_cubit/auth_state.dart';
import 'package:pokemon_app_bloc/screens/login_screen.dart';
import 'package:pokemon_app_bloc/screens/tabs/all_pokemons/all_pokemons_screen.dart';
import 'package:pokemon_app_bloc/screens/tabs/favourites/favourite_pokemon_screen.dart';
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
