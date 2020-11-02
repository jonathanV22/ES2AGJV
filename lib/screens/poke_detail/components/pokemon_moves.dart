import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon_moves_model.dart';
import 'package:pokedex/services/api_provider.dart';

import '../../../helpers/colorTheme.dart';
import '../../../helpers/colorTheme.dart';
import '../../../helpers/colorTheme.dart';
import '../../../helpers/customWidget.dart';
import '../../../helpers/customWidget.dart';

class PokemonMoves extends StatelessWidget {
  final String nombrePokemon;
  final String tipo;
  PokemonMoves({this.nombrePokemon, this.tipo});
  List<Moves> moves = [];
  ApiProvider apiProvider = ApiProvider();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<PokemonMovesModel>(
        future: apiProvider.obtenerMovimientos(nombrePokemon),
        builder:
            (BuildContext context, AsyncSnapshot<PokemonMovesModel> snapshot) {
          if (snapshot.hasData) {
            return Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                width: fullWidth(context),
                child: Wrap(
                    children: snapshot.data.moves
                        .map((move) => Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            height: getDimention(context, 30),
                            margin: EdgeInsets.symmetric(
                                horizontal: 6, vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: setSecondaryColor(tipo),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(color: Colors.grey)
                                ]),
                            child: Text(
                              move.move.name,
                              style: TextStyle(
                                  fontSize: getFontSize(context, 18),
                                  color: Colors.white),
                            )))
                        .toList()));
          } else {
            return Column(
              children: [CircularProgressIndicator()],
            );
          }
        },
      ),
    );
  }
}
