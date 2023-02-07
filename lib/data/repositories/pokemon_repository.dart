import 'package:dio/dio.dart';
import 'package:pokemon_app_bloc/data/models/pokemon_model.dart';
import 'package:pokemon_app_bloc/data/repositories/api/api.dart';

class PokemonRepository {
  API api = API();
  Future<List<PokemonModel>> fetchPokemon() async {
    try {
      Response response = await api.sendRequest.get("/pokemon");
      List<dynamic> pokemonModel = response.data["results"];
      return pokemonModel
          .map((pokemonObj) => PokemonModel.fromJson(pokemonObj))
          .toList();
    } catch (e) {
      throw e;
    }
  }
}
