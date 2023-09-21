import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pokecode/screens/pokemon/cadastro_screen.dart';
import 'package:pokecode/screens/pokemon/pokecenter_screen.dart';
import 'package:pokecode/screens/pokemon/pokedex_screen.dart';
import 'package:pokecode/screens/pokemon/recommendation/recomendacao_screen.dart';
import 'package:pokecode/screens/pokemon/sacola_screen.dart';
import 'package:pokecode/screens/user/esqueci_senha_screen.dart';
import 'package:pokecode/screens/user/login_screen.dart';
import 'package:pokecode/screens/user/profile_screen.dart';

import 'firebase_options.dart';

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
        '/sacola': (context) => BagScreen(),
        '/pokecenter': (context) => PokecenterScreen(),
        '/login': (context) => const LoginScreen(),
        '/cadastro': (context) => const CadastroScreen(),
        '/esqueci-senha': (context) => const EsqueciSenhaScreen(),
        '/': (context) => const PokedexScreen(),
        '/recomendacoes': (context) => const RecommendationScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}
