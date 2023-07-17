import 'package:flutter/material.dart';
import 'package:pokecode/widgets/app_bar_widget.dart';
import '../widgets/bottom_navigation_bar_widget.dart';
import '../widgets/card_simples_recomendacao_widget.dart';

class RecomendacaoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(currentIndex: 0),
      body: Container(
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  CardSimplesRecomendacaoWidget(currentIndex: 0),
                  CardSimplesRecomendacaoWidget(currentIndex: 1),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  CardSimplesRecomendacaoWidget(currentIndex: 3),
                  CardSimplesRecomendacaoWidget(currentIndex: 4),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  CardSimplesRecomendacaoWidget(currentIndex: 6),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(currentIndex: 2,),
    );
  }
}
