import 'package:flutter/material.dart';
import '../widgets/bottom_navigation_bar_widget.dart';

class PokedexScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokedex'),
      ),
      body: Container(
        // Seu conteúdo do corpo aqui...
      ),
      bottomNavigationBar: BottomNavigationBarWidget(currentIndex: 1,),
    );
  }
}
