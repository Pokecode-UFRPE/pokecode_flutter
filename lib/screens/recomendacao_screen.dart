import 'package:flutter/material.dart';
import 'package:pokecode/widgets/app_bar_widget.dart';
import '../widgets/bottom_navigation_bar_widget.dart';

class RecomendacaoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(currentIndex: 0),
      body: Container(
      ),
      bottomNavigationBar: BottomNavigationBarWidget(currentIndex: 2,),
    );
  }
}
