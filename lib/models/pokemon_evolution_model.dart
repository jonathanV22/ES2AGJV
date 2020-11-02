import 'package:pokedex/models/pokemon_evolution_chain.dart';
import 'package:pokedex/models/pokemon_evolution_detail.dart';
import 'package:pokedex/models/pokemon_evolution_species.dart';

class PokemonEvolutionModel {
  PokemonEvolutionDetail pokemonDetail;
  PokemonEvolutionSpecies pokemonSpecies;
  PokemonEvolutionChain pokemonChain;

  PokemonEvolutionModel(
      {this.pokemonDetail, this.pokemonSpecies, this.pokemonChain});
}
