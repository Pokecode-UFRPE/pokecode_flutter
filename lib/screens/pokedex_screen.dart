import 'package:flutter/material.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/bottom_navigation_bar_widget.dart';

class PokedexScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(currentIndex: 0),
      body: Container(),
      bottomNavigationBar: BottomNavigationBarWidget(
        currentIndex: 1,
      ),
    );
  }
}

// Navigator.pushNamed(context,  '/second' );
