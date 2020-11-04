import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon_evolution_model.dart';
import 'package:pokedex/models/pokemon_list_model.dart';
import 'package:pokedex/models/pokemon_stats_detail_model.dart';
import 'package:pokedex/services/api_provider.dart';

class PokemonEvolutions extends StatefulWidget {
  final String nombrePokemon;
  PokemonEvolutions({this.nombrePokemon});
  @override
  _PokemonEvolutionsState createState() =>
      _PokemonEvolutionsState(nombrePokemon);
}

class _PokemonEvolutionsState extends State<PokemonEvolutions> {
  final String nombrePokemon;
  List<PokemonListModel> miLista = [];
  _PokemonEvolutionsState(this.nombrePokemon);
  ApiProvider apiProvider = ApiProvider();
  @override
  void initState() {
    super.initState();
    apiProvider.obtenerListaPokemon().then((response) {
      // ignore: unused_element
      setState(() {
        miLista = response;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<PokemonEvolutionModel>(
          future: apiProvider.obtenerEvolucion(nombrePokemon),
          builder: (BuildContext context,
              AsyncSnapshot<PokemonEvolutionModel> snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/images/pokeball.png',
                        height: 100,
                        color: Color(0xffe3e3e3).withAlpha(100),
                      ),
                      Image.network(
                        '${miLista[snapshot.data.pokemonDetail.id - 1].image}',
                        height: 70,
                      )
                    ],
                  ),
                  Text('${snapshot.data.pokemonDetail.species.name}')
                ],
              );
            } else {
              return Column(
                children: [CircularProgressIndicator()],
              );
            }
          },
        )
      ],
    );
  }
}
