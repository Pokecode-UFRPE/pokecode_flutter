import 'package:flutter/material.dart';

class CardSimplesRecomendacaoWidget extends StatelessWidget {
  final int currentIndex;
  final String type;

  const CardSimplesRecomendacaoWidget({required this.currentIndex, this.type = 'water'});

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
                'assets/images/water.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Image.asset(
                'assets/images/recomendacao_icon.png',
                fit: BoxFit.cover,
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Color.fromARGB(255, 245, 85, 85),
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
