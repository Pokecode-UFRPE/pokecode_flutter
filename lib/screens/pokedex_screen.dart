import 'package:flutter/material.dart';
import 'package:pokecode/widgets/app_bar_widget.dart';
import '../widgets/bottom_navigation_bar_widget.dart';
import '../widgets/card_pokemon_horizontal.dart';

class PokedexScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(currentIndex: 1),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 10),
            Align(
              alignment: Alignment.topCenter,
              child: CardPokemonHorizontalWidget(
                currentIndex: 1,
                img_pokemon: 'exemplo',
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        currentIndex: 1,
      ),
    );
  }
}
