import 'package:flutter/material.dart';

import '../services/db_firestore.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/bottom_navigation_bar_widget.dart';
import '../widgets/card_pokemon_horizontal.dart';

class PokedexScreen extends StatelessWidget {
  const PokedexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(currentIndex: 0),
      body:
          // Column(children: [constructorCard(4)],),
          padrao(),
      bottomNavigationBar: BottomNavigationBarWidget(
        currentIndex: 1,
      ),
    );
  }
}

Widget padrao() {
  return ListView.builder(
    itemCount: 899,
    itemBuilder: (context, index) {
      return constructorCard(index + 1);
    },
  );
}

constructorCard(int index) {
  return FutureBuilder<Pokemon?>(
    future: getPokemon(index),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: Image.asset('assets/images/spinner_ball.gif', height: 40),
        );
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else {
        Pokemon? pk = snapshot.data;
        if (pk != null) {
          return CardPokemonHorizontalWidget(currentIndex: 0, pokemon: pk);
        } else {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: Image.asset('assets/images/spinner_ball.gif', height: 40),
          );
        }
      }
    },
  );
}
