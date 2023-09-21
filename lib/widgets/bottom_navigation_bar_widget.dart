import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final int currentIndex;

  BottomNavigationBarWidget({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/icon-bag.png',
            height: 50,
          ),
          label: 'Sacola',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/icon-pokedex.png',
            height: 50,
          ),
          label: 'Pokedex',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/icon-recommendation.png',
            height: 50,
          ),
          label: 'Recomendações',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/pharmacy.png',
            height: 50,
          ),
          label: 'Pokecenter',
        ),
      ],
      onTap: (int index) {
        if (index == 0) {
          Navigator.pushReplacementNamed(context, '/sacola');
        } else if (index == 1) {
          Navigator.pushReplacementNamed(context, '/');
        } else if (index == 2) {
          Navigator.pushReplacementNamed(context, '/recomendacoes');
        } else if (index == 3) {
          Navigator.pushReplacementNamed(context, '/pokecenter');
        }
      },
    );
  }
}
