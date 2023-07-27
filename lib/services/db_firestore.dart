import 'package:firebase_database/firebase_database.dart';

Future<Pokemon?> getPokemon(int index) async {
  final ref = FirebaseDatabase.instance.ref();
  final DataSnapshot snapshot = await ref.child('pokemon/$index').get(); 

  if (snapshot.exists) {
    Map<String, dynamic>? json = snapshot.value as Map<String, dynamic>?;
    print(json);
    Pokemon result = Pokemon.fromJson(json!);
    return result;
  }
}

class Pokemon {
  String name;
  int pokedex_number;
  Pokemon(this.name, this.pokedex_number);
  Pokemon.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        pokedex_number = json['pokedex_number'];
  Map<String, dynamic> toJson() => {
        'name': name,
        'pokedex_number': pokedex_number,
      };
  @override
  String toString() {
    return 'nome: $name, pokedex number: $pokedex_number';
  }
}
