import 'package:flutter/material.dart';

class CardSimplesRecomendacaoWidget extends StatelessWidget {
  final int currentIndex;
  final String type;
  final String img_pokemon;

  CardSimplesRecomendacaoWidget(
      {required this.currentIndex, required this.type, required this.img_pokemon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 3,
      height: MediaQuery.of(context).size.height / 3,
      child: Card(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/bg_recomendacoes/$type.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Image.asset(
                'assets/images/$img_pokemon.png',
                fit: BoxFit.fitWidth,
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Color.fromARGB(255, 255, 255, 255),
                onTap: () {
                  debugPrint('Card tapped.');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
