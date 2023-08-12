import 'package:firebase_database/firebase_database.dart';

// ignore: body_might_complete_normally_nullable
Future<Pokemon?> getPokemon(int index) async {
  final ref = FirebaseDatabase.instance.ref();
  final DataSnapshot snapshot = await ref.child('/pokemon/$index').get();

  if (snapshot.exists) {
    try {
      Map<dynamic, dynamic> map =
          snapshot.value as Map<dynamic, dynamic>;
      Map<String, dynamic>? json =
          map.cast<String, dynamic>();
      if (json != null) {
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
      // print(result);
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

Future<List<Pokemon>> getPokemonsInput(String name) async {
  final ref = FirebaseDatabase.instance.ref().child('pokemon');
  Query query = ref.orderByChild('name').startAt(name).endAt("$name\uf8ff");
  DataSnapshot snapshot = (await query.once()).snapshot;
  List<Pokemon> resultList = [];

  if (snapshot.exists) {
    try {
      Map<dynamic, dynamic> map = snapshot.value as Map<dynamic, dynamic>;
      Map<String, dynamic>? json = map.cast<String, dynamic>();
      // print(map);
      if (json != null) {
        if (map is Map) {
          map.forEach((key, value) {
            if (value is Map<String, dynamic>) {
              Pokemon result = Pokemon.fromJson(value);
              resultList.add(result);
            }
          });
        }
      }
    } catch (error) {
      print("Error: $error");
    }
  }
  return resultList;
}

Future<List<Pokemon>> getPokemonsFiltroString(String aux, String tipoDeBusca) async {
  final ref = FirebaseDatabase.instance.ref().child('pokemon');
  Query query = ref.orderByChild(tipoDeBusca).startAt(aux).endAt(aux + "\uf8ff");
  DataSnapshot snapshot = (await query.once()).snapshot;
  List<Pokemon> resultList = [];

  if (snapshot.exists) {
    try {
      Map<dynamic, dynamic> map = snapshot.value as Map<dynamic, dynamic>;
      Map<String, dynamic>? json = map.cast<String, dynamic>();
      if (json != null) {
        if (map is Map) {
          map.forEach((key, value) {
            if (value is Map<String, dynamic>) {
              Pokemon result = Pokemon.fromJson(value);
              resultList.add(result);
            }
          });
        }
      }
    } catch (error) {
      print("Error: $error");
    }
  }
  return resultList;
}