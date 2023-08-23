import 'package:firebase_database/firebase_database.dart';

// ignore: body_might_complete_normally_nullable
Future<Pokemon?> getPokemon(int index) async {
  final ref = FirebaseDatabase.instance.ref();
  final DataSnapshot snapshot = await ref.child('/pokemon/$index').get();

  if (snapshot.exists) {
    try {
      Map<dynamic, dynamic> map = snapshot.value as Map<dynamic, dynamic>;
      Map<String, dynamic>? json = map.cast<String, dynamic>();
      if (json != null) {
        Pokemon result = Pokemon.fromJson(json);
        print(result);
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
  int pokedexNumber;
  String genIntroduced;
  String primaryColor;
  String shape;
  String typing;
  double height;
  double weight;
  int hp;
  int attack;
  int defense;
  int speed;
  int baseExperience;
  bool canEvolve;
  String raridade;

  Pokemon(
      this.name, this.pokedexNumber, this.genIntroduced, this.primaryColor, this.shape, this.typing, this.height, this.weight, this.hp, this.attack, this.defense,
      this.speed, this.baseExperience, this.canEvolve, this.raridade);

  Pokemon.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        pokedexNumber = json['pokedex_number'],
        genIntroduced = json['gen_introduced'],
        primaryColor = json['primary_color'],
        shape = json['shape'],
        typing = json['typing'],
        height = json['height'],
        weight = json['weight'],
        hp = json['hp'],
        attack = json['attack'],
        defense = json['defense'],
        speed = json['speed'],
        baseExperience = json['base_experience'],
        canEvolve = json['can_evolve'],
        raridade = json['raridade'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'pokedex_number': pokedexNumber,
        'gen_introduced': genIntroduced,
        'primary_color': primaryColor,
        'shape': shape,
        'typing': typing,
        'height': height,
        'weight': weight,
        'hp': hp,
        'attack': attack,
        'defense': defense,
        'speed': speed,
        'base_experience': baseExperience,
        'can_evolve': canEvolve,
        'raridade': raridade,
      };
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

Future<List<Pokemon>> getPokemonsFiltroString(
    String aux, String tipoDeBusca) async {
  final ref = FirebaseDatabase.instance.ref().child('pokemon');
  Query query =
      ref.orderByChild(tipoDeBusca).startAt(aux).endAt(aux + "\uf8ff");
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
