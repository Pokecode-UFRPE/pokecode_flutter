import 'dart:math';
import 'package:flutter/material.dart';
import '../services/db_firestore.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/bottom_navigation_bar_widget.dart';
import '../widgets/card_recomendacao_widget.dart';
import '../widgets/card_simples_recomendacao_widget.dart';

class RecomendacaoScreen extends StatefulWidget {
  const RecomendacaoScreen({Key? key}) : super(key: key);

  @override
  _RecomendacaoScreenState createState() => _RecomendacaoScreenState();
}

class _RecomendacaoScreenState extends State<RecomendacaoScreen> {
  late List<int> cardList;
  late int star;

  @override
  void initState() {
    super.initState();
    cardList = generateRandomNumbers(22);
    star = cardList.removeAt(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [constructorStarCard(star)],
            ),
            GridView.builder(
              physics: PageScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.6,
                  ),
              itemCount: cardList.length,
              itemBuilder: (BuildContext context, int index) {
                return constructorComonCard(cardList[index]);
              },
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
        return const CircularProgressIndicator();
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
        return Image.asset(
          'assets/images/spinner_ball.gif',
          height: 40,
        );
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else {
        Pokemon? pk1 = snapshot.data;
        return CardSimplesRecomendacaoWidget(currentIndex: 0, pokemon: pk1);
      }
    },
  );
}

List<int> generateRandomNumbers(int count) {
  List<int> randomNumbers = [];
  Random random = Random();

  for (int i = 0; i < count; i++) {
    int randomNumber = random.nextInt(600);
    randomNumbers.add(randomNumber);
  }

  return randomNumbers;
}
