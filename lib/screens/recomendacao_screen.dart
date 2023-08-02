import 'dart:math';
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
                constructorStarCard(4)
              ],
            ),
            Row(
              children: [
                constructorComonCard(randomize()),
                constructorComonCard(randomize()),
                constructorComonCard(randomize())
              ],
            ),
            Row(
              children: [
                constructorComonCard(randomize()),
                constructorComonCard(randomize()),
                constructorComonCard(randomize())
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

constructorStarCard(int index) {
  return FutureBuilder<Pokemon?>(
    future: getPokemon(index),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else {
        Pokemon? pk = snapshot.data;        
        return CardRecomendacaoWidget(currentIndex: 0, pokemon: pk);
      }
    },
  );
}

constructorComonCard(int index) {
  return FutureBuilder<Pokemon?>(
    future: getPokemon(index),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Image.asset('assets/images/spinner_ball.gif',height: 40,);
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else {
        Pokemon? pk1 = snapshot.data;        
        return CardSimplesRecomendacaoWidget(currentIndex: 0, pokemon: pk1);
      }
    },
  );
}

randomize() {
  Random random = Random();
  int randomNumber = random.nextInt(898);
  return randomNumber;
}
