import 'package:firebase_database/firebase_database.dart';

import '../models/Pokemon.dart';

class PokemonRepository {

  Future<Pokemon?> getPokemon(int index) async {
    final ref = FirebaseDatabase.instance.ref();
    final DataSnapshot snapshot = await ref.child('/pokemon/$index').get();
    if (snapshot.exists) {
      try {
        Map<dynamic, dynamic> map = snapshot.value as Map<dynamic, dynamic>;
        Map<String, dynamic>? json = map.cast<String, dynamic>();
        Pokemon result = Pokemon.fromJson(json);
        return result;
      } catch (e) {
        print(e);
      }
    }
    return null;
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
        print(json);
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

  Future<List<Pokemon>> getPokemonsFiltroString(String aux,
      String tipoDeBusca) async {
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
}
