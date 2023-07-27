import 'package:flutter/material.dart';
import 'package:pokecode/widgets/app_bar_widget.dart';
import '../services/db_firestore.dart';
import '../widgets/bottom_navigation_bar_widget.dart';
import '../widgets/card_recomendacao_widget.dart';
import '../widgets/card_simples_recomendacao_widget.dart';

class RecomendacaoScreen extends StatelessWidget {
  const RecomendacaoScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(currentIndex: 0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                CardRecomendacaoWidget(currentIndex: 0, img_pokemon: '001'),
              ],
            ),
            Row(
              children: [
                FutureBuilder<Pokemon?>(
                  future: getPokemon(1),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(); 
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      Pokemon? nsei = snapshot.data;
                      return Column(
                        children: [
                          Text(nsei!.name),
                          Text('${nsei.pokedex_number}')
                        ],
                      );
                    }
                  },
                ),
              ]
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
