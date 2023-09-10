import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pokecode/screens/pokemon/recommendation/widgets/row_recommendation_widget.dart';

import '../../../models/Pokemon.dart';
import '../../../repository/PokemonRepository.dart';
import '../../../widgets/app_bar_widget.dart';
import '../../../widgets/bottom_navigation_bar_widget.dart';
import 'widgets/card_recomendacao_widget.dart';

class RecommendationScreen extends StatefulWidget {
  const RecommendationScreen({Key? key}) : super(key: key);

  @override
  _RecommendationScreenState createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  late List<int> cardList;
  late int star;
  String _inputValue = "";
  final List _filterAndValue = ['', ''];

  @override
  void initState() {
    super.initState();
    cardList = generateRandomNumbers(22);
    star = cardList.removeAt(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        currentIndex: 0,
        valorInput: _inputValue,
        filtroEValorAppBar: _filterAndValue,
        onInputChanged: (newValue) {
          setState(() {
            _inputValue = newValue;
          });
        },
        onPopupChanged: (newValue) {
          setState(() {
            _inputValue = newValue as String;
          });
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [constructorStarCard(star)],
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return RowRecommendationWidget();
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
  final PokemonRepository pokemonRepository = PokemonRepository();
  return FutureBuilder<Pokemon?>(
    future: pokemonRepository.getPokemon(index),
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

List<int> generateRandomNumbers(int count) {
  List<int> randomNumbers = [];
  Random random = Random();

  for (int i = 0; i < count; i++) {
    int randomNumber = random.nextInt(600);
    randomNumbers.add(randomNumber);
  }

  return randomNumbers;
}
