import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pokecode/screens/cadastro_screen.dart';
import 'package:pokecode/screens/esqueci_senha_screen.dart';
import 'package:pokecode/screens/login_screen.dart';

import 'firebase_options.dart';
import 'screens/pokedex_screen.dart';
import 'screens/recomendacao_screen.dart';
import 'screens/sacola_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  User? currentUser = FirebaseAuth.instance.currentUser;
  String initialRoute = currentUser == null ? '/login' : '/';
  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({required this.initialRoute, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PokeCode',
      initialRoute: initialRoute,
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
