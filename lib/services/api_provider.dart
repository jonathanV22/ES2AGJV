import 'package:dio/dio.dart';
import 'package:pokedex/models/pokemon_about_detail_model.dart';
import 'package:pokedex/models/pokemon_about_location_model.dart';
import 'package:pokedex/models/pokemon_about_model.dart';
import 'package:pokedex/models/pokemon_about_species_model.dart';
import 'package:pokedex/models/pokemon_evolution_chain.dart';
import 'package:pokedex/models/pokemon_evolution_detail.dart';
import 'package:pokedex/models/pokemon_evolution_model.dart';
import 'package:pokedex/models/pokemon_evolution_species.dart';
import 'package:pokedex/models/pokemon_list_model.dart';
import 'package:pokedex/models/pokemon_stats_detail_model.dart';
import 'package:pokedex/models/pokemon_stats_model.dart';
import 'package:pokedex/models/pokemon_stats_species_model.dart';
import 'package:pokedex/models/pokemon_moves_model.dart';

class ApiProvider {
  Dio dio = Dio();

  Future<List<PokemonListModel>> obtenerListaPokemon() async {
    List<PokemonListModel> lista = [];
    try {
      Response resp =
          await dio.get('https://pokedexvuejs.herokuapp.com/pokedexdb');
      final pokemones = PokemonListResponse.fromJsonList(resp.data);
      lista = pokemones.items;
    } catch (e) {}
    return lista;
  }

  Future<PokemonAboutModel> obtenerInfoAboutPokemon(String nombrePoke) async {
    var pokeAbout = PokemonAboutModel();
    try {
      Response respA =
          await dio.get('https://pokeapi.co/api/v2/pokemon/$nombrePoke');
      final pokeDetail = PokeAboutDetail.fromJson(respA.data);
      Response respB = await dio
          .get('https://pokeapi.co/api/v2/pokemon/${pokeDetail.id}/encounters');
      final pokeListLocation =
          PokemonAboutLocationListModel.fromJsonList(respB.data);
      Response respC = await dio
          .get('https://pokeapi.co/api/v2/pokemon-species/${pokeDetail.id}');
      final pokeSpecies = PokeAboutSpecies.fromJson(respC.data);

      pokeAbout = PokemonAboutModel(
          pokeDetail: pokeDetail,
          pokeLocations: pokeListLocation.items,
          pokeSpecies: pokeSpecies);
    } catch (e) {}

    return pokeAbout;
  }

  Future<PokemonStatsModel> obtenerInfoStatsPokemon(String nombrePoke) async {
    var pokeStats = PokemonStatsModel();
    try {
      Response respA =
          await dio.get('https://pokeapi.co/api/v2/pokemon/$nombrePoke');
      final pokeStatDetail = PokeStatsDetail.fromJson(respA.data);
      Response respB = await dio.get(
          'https://pokeapi.co/api/v2/pokemon-species/${pokeStatDetail.id}');
      final pokeStatSpecies = PokeStatsSpecies.fromJson(respB.data);
      print(pokeStatSpecies);
      pokeStats = PokemonStatsModel(
          pokeStatDetail: pokeStatDetail, pokeStatSpecies: pokeStatSpecies);
    } catch (e) {}

    return pokeStats;
  }

  Future<PokemonEvolutionModel> obtenerEvolucion(String nombrePoke) async {
    var pokeEvolution = PokemonEvolutionModel();
    try {
      Response respA =
          await dio.get('https://pokeapi.co/api/v2/pokemon/$nombrePoke');
      final pokemonDetail = PokemonEvolutionDetail.fromJson(respA.data);
      Response respB = await dio.get(
          'https://pokeapi.co/api/v2/pokemon-species/${pokemonDetail.id}/');
      final pokemonSpecies = PokemonEvolutionSpecies.fromJson(respB.data);
      Response respC = await dio.get(
          'https://pokeapi.co/api/v2/evolution-chain/${pokemonDetail.id}/');
      final pokemonChain = PokemonEvolutionChain.fromJson(respC.data);
      pokeEvolution = PokemonEvolutionModel(
          pokemonDetail: pokemonDetail,
          pokemonSpecies: pokemonSpecies,
          pokemonChain: pokemonChain);
    } catch (e) {}
    return pokeEvolution;
  }

  Future<PokemonMovesModel> obtenerMovimientos(String nombrePoke) async {
    var pokeMoves = PokemonMovesModel();
    try {
      Response respA =
          await dio.get('https://pokeapi.co/api/v2/pokemon/$nombrePoke');
      final pokeMove = PokemonMovesModel.fromJson(respA.data);
      pokeMoves = pokeMove;
    } catch (e) {}
    return pokeMoves;
  }
}
