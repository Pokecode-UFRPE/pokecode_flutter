import 'package:firebase_database/firebase_database.dart';

// ignore: body_might_complete_normally_nullable
Future<Pokemon?> getPokemon(int index) async {
  final ref = FirebaseDatabase.instance.ref();
  final DataSnapshot snapshot = await ref.child('/$index').get(); 

  if (snapshot.exists) {
    Map<String, dynamic>? json = snapshot.value as Map<String, dynamic>?;
    print(json);
    Pokemon result = Pokemon.fromJson(json!);
    return result;
  }
}

class Pokemon {
  String name;
  String typing;
  // ignore: non_constant_identifier_names
  int pokedex_number;
  Pokemon(this.name, this.pokedex_number, this.typing);
  Pokemon.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        typing = json['typing'],
        pokedex_number = json['pokedex_number'];
  Map<String, dynamic> toJson() => {
        'name': name,
        'typing': typing,
        'pokedex_number': pokedex_number,
      };
  @override
  String toString() {
    return 'nome: $name, typing: $typing, pokedex number: $pokedex_number';
  }
}
