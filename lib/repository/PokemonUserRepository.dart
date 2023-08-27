import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/PokemonCapture.dart';

class PokemonUserRepository {
  Future<PokemonCapture> addPokemon(PokemonCapture pokemon) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('bag')
        .doc(pokemon.id)
        .set(pokemon.toMap());

    return pokemon;
  }

  Future<PokemonCapture?> findById(String pokemonId) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('bag')
        .doc(pokemonId)
        .get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
      return PokemonCapture(
          id: data['id'],
          gosta: data['gosta'],
          favorito: data['favorito'],
          capturado: data['capturado']);
    } else {
      return null;
    }
  }

  Future<List<PokemonCapture>> findAllCapturedPokemon() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('bag')
        .where('capturado', isEqualTo: true)
        .get();

    List<PokemonCapture> capturedPokemons = [];

    for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
      capturedPokemons.add(PokemonCapture(
        id: data['id'],
        gosta: data['gosta'],
        favorito: data['favorito'],
        capturado: data['capturado'],
      ));
    }

    return capturedPokemons;
  }

  Future<List<PokemonCapture>> findAllPokemon() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    List<PokemonCapture> capturedPokemons = [];
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('bag')
          .where('gosta', isNotEqualTo: 3)
          .get();
      for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
        capturedPokemons.add(PokemonCapture(
          id: data['id'],
          gosta: data['gosta'],
          favorito: data['favorito'],
          capturado: data['capturado'],
        ));
      }
    } catch (e) {
      print(e);
    }
    return capturedPokemons;
  }

  Future<void> updatePokemon(PokemonCapture pokemon) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    PokemonCapture? pokemonCapture = await findById(pokemon.id);
    if (pokemonCapture == null) {
      await addPokemon(pokemon);
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('bag')
        .doc(pokemon.id.toString())
        .update(pokemon.toMap())
        .catchError(
            (error) => throw Exception("Erro ao atualizar Pokémon: $error"));
  }
}
