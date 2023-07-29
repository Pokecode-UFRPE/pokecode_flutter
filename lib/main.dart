import 'package:flutter/material.dart';
import 'package:pokecode/screens/cadastro_screen.dart';
import 'package:pokecode/screens/esqueci_senha_screen.dart';
import 'package:pokecode/screens/login_screen.dart';

import 'screens/pokedex_screen.dart';
import 'screens/sacola_screen.dart';
import 'screens/recomendacao_screen.dart';

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
        '/login': (context) => LoginScreen(),
        '/cadastro': (context) => CadastroScreen(),
        '/esqueci-senha': (context) => EsqueciSenhaScreen(),
        '/': (context) => PokedexScreen(),
        '/recomendacoes': (context) => RecomendacaoScreen(),
      },
    );
  }
}

// Resto do código...
