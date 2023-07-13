import 'package:flutter/material.dart';
import '../widgets/bottom_navigation_bar_widget.dart';

class RecomendacaoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recomendação'),
      ),
      body: Container(
        // Seu conteúdo do corpo aqui...
      ),
      bottomNavigationBar: BottomNavigationBarWidget(currentIndex: 2,),
    );
  }
}
