import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app_bloc/cubits/pokemon_cubit/pokemon_cubit.dart';
import 'package:pokemon_app_bloc/data/models/pokemon_model.dart';
import 'package:pokemon_app_bloc/resources/app_theme.dart';

class PokemonViewWidget extends StatelessWidget {
  PokemonViewWidget(
      {Key? key, required this.pokemon, required this.onPressed, this.icon})
      : super(key: key);
  PokemonModel pokemon;
  VoidCallback onPressed;
  IconData? icon;
  @override
  Widget build(BuildContext context) {
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
          color: AppTheme.primaryColor),
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
              onPressed: onPressed,
              icon: Icon(
                icon!,
                color: Colors.white,
              )),
        ],
      ),
    );
  }
}
