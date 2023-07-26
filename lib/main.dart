import 'package:flutter/material.dart';
import 'screens/pokedex_screen.dart';
import 'screens/sacola_screen.dart';
import 'screens/recomendacao_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
        '/recomendacoes': (context) => const RecomendacaoScreen(),
      },
    );
  }
}
