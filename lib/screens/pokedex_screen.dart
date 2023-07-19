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
            Row(
              children: [
                CardPokemonHorizontalWidget(currentIndex: 1),
              ],
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
