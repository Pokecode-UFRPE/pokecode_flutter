import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final int currentIndex;

  const BottomNavigationBarWidget({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Sacola',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Pokedex',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
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
