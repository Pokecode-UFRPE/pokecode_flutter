import 'package:firebase_database/firebase_database.dart';

// ignore: body_might_complete_normally_nullable
Future<Pokemon?> getPokemon(int index) async {
  final ref = FirebaseDatabase.instance.ref();
  final DataSnapshot snapshot = await ref.child('/pokemon/$index').get();

  if (snapshot.exists) {
    // Alteração aqui: mudança na ordem da verificação
    try {
      print(snapshot.value);
      Map<dynamic, dynamic> map =
          snapshot.value as Map<dynamic, dynamic>; // Alteração aqui
      Map<String, dynamic>? json =
          map.cast<String, dynamic>(); // Alteração aqui: conversão explícita
      // print("=====================");
      if (json != null) {
        // print(json);
        Pokemon result = Pokemon.fromJson(json);
        return result;
      }
    } catch (e) {
      print(e);
    }
  }
  return null;
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

Future<List<String>?> getTypes() async {
  final ref = FirebaseDatabase.instance.ref();
  final DataSnapshot snapshot = await ref.child('/typing/').get();

  if (snapshot.exists) {
    try {
      List<dynamic> dataList = snapshot.value as List<dynamic>;
      List<String> result = dataList.map((item) => item.toString()).toList();
      return result;
    } catch (e) {
      print(e);
    }
  }
  return null;
}

Future<List<String>?> getColors() async {
  final ref = FirebaseDatabase.instance.ref();
  final DataSnapshot snapshot = await ref.child('/primary_color/').get();

  if (snapshot.exists) {
    try {
      List<dynamic> dataList = snapshot.value as List<dynamic>;
      List<String> result = dataList.map((item) => item.toString()).toList();
      return result;
    } catch (e) {
      print(e);
    }
  }
  return null;
}
Future<List<String>?> getShapes() async {
  final ref = FirebaseDatabase.instance.ref();
  final DataSnapshot snapshot = await ref.child('/shape/').get();

  if (snapshot.exists) {
    try {
      List<dynamic> dataList = snapshot.value as List<dynamic>;
      List<String> result = dataList.map((item) => item.toString()).toList();
      return result;
    } catch (e) {
      print(e);
    }
  }
  return null;
}

