import 'package:flutter/material.dart';
import 'package:pokecode/widgets/app_bar_widget.dart';
import '../widgets/bottom_navigation_bar_widget.dart';
import '../widgets/card_recomendacao_widget.dart';
import '../widgets/card_simples_recomendacao_widget.dart';

class RecomendacaoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(currentIndex: 0),
      body: Container(
        child: Column(
          children: [
            Row(
              children: [
                CardRecomendacaoWidget(currentIndex: 0, img_pokemon: 'exemplo'),
              ],
            ),
            Row(
              children: [
                CardSimplesRecomendacaoWidget(
                    currentIndex: 0, type: 'bug', img_pokemon: 'exemplo'),
                CardSimplesRecomendacaoWidget(
                    currentIndex: 0, type: 'flying', img_pokemon: 'exemplo'),
                CardSimplesRecomendacaoWidget(
                    currentIndex: 0, type: 'fire', img_pokemon: 'exemplo'),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        currentIndex: 2,
      ),
    );
  }
}
