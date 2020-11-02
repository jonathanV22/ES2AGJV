import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon_evolution_model.dart';
import 'package:pokedex/models/pokemon_list_model.dart';
import 'package:pokedex/services/api_provider.dart';

class PokemonEvolutions extends StatelessWidget {
  final String nombrePokemon;
  PokemonEvolutions({this.nombrePokemon});

  ApiProvider apiProvider = ApiProvider();
  @override
  Widget build(BuildContext context) {
    Container(
      child: FutureBuilder<PokemonEvolutionModel>(
          future: apiProvider.obtenerEvolucion(nombrePokemon),
          builder: (BuildContext context,
              AsyncSnapshot<PokemonEvolutionModel> snapshot) {
            if (snapshot.hasData) {
              return Text('ok');
            } else {
              return Text('error');
            }
          }),
    );
    Container(
      child: FutureBuilder<List<PokemonListModel>>(
          future: apiProvider.obtenerListaPokemon(),
          builder: (BuildContext context,
              AsyncSnapshot<List<PokemonListModel>> snapshot) {
            if (snapshot.hasData) {
              return Text('ok');
            } else {
              return Text('error');
            }
          }),
    );
  }
}
