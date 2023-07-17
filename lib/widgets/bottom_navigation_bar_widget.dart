import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final int currentIndex;

   BottomNavigationBarWidget({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      items:  <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Image.asset('assets/images/bag_icon.png', height: 60,),
          label: 'Sacola',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/images/pokedex_icon.png', height: 60,),
          label: 'Pokedex',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/images/recomendacao_icon.png', height: 60,),
          label: 'Recomendações',
        ),
      ],
      onTap: (int index) {
        if (index == 0) {
          Navigator.pushReplacementNamed(context, '/sacola');
        } else if (index == 1) {
          Navigator.pushReplacementNamed(context, '/');
        } else if (index == 2) {
          Navigator.pushReplacementNamed(context, '/recomendacoes');
        }
      },
    );
  }
}
