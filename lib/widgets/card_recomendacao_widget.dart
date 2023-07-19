import 'package:flutter/material.dart';
import 'package:pokecode/widgets/popup_pokemon_selected.dart';

class CardRecomendacaoWidget extends StatelessWidget {
  final int currentIndex;
  final String img_pokemon;

  CardRecomendacaoWidget(
      {required this.currentIndex, required this.img_pokemon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width / 3,
      child: Card(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/bg_recomendacoes/star.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Image.asset(
                'assets/images/$img_pokemon.png',
                fit: BoxFit.fitHeight,
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Color.fromARGB(255, 255, 255, 255),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return PopupPokemonSelected(
                        img_pokemon: img_pokemon, name: 'cindaquill', number_pokedex: '155', types: ['fire', 'bug'],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
