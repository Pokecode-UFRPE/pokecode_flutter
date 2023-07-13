import 'package:flutter/material.dart';
import 'screens/pokedex_screen.dart';
import 'screens/sacola_screen.dart';
import 'screens/recomendacao_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PokeCode',
      initialRoute: '/',
      routes: {
        '/sacola': (context) => SacolaScreen(),
        '/': (context) => PokedexScreen(),
        '/recomendacoes': (context) => RecomendacaoScreen(),
      },
    );
  }
}

// Resto do código...
