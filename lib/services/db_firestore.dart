import 'package:firebase_database/firebase_database.dart';

// Modifique a função para receber o índice como parâmetro
Future<String?> getPokemonName(int index) async {
  final ref = FirebaseDatabase.instance.reference();
  final snapshot = await ref.child('pokemon/$index/name').get(); // Acessa o campo 'name' do índice fornecido no caminho 'pokemon'

  if (snapshot.exists) {
    return snapshot.value as String; // Supondo que 'name' é do tipo String
  } else {
    return 'No data available.';
  }
}
