import 'package:flutter/material.dart';
import '../widgets/bottom_navigation_bar_widget.dart';

class SacolaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bag'),
      ),
      body: Container(
        // Seu conteúdo do corpo aqui...
      ),
      bottomNavigationBar: BottomNavigationBarWidget(currentIndex: 0,),
    );
  }
}
