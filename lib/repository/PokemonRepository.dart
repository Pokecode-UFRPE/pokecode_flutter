import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/Pokemon.dart';

class PokemonRepository {
  Future<Pokemon> adicionarPokemon(Pokemon pokemon) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('bag')
        .doc(pokemon.id)
        .set(pokemon.toMap());

    return pokemon;
  }

  Future<Pokemon?> findById(String pokemonId) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('bag')
        .doc(pokemonId)
        .get();

    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
      return Pokemon(
          id: data['id'],
          favorito: data['favorito'],
          capturado: data['capturado']);
    } else {
      return null;
    }
  }

  Future<void> updatePokemon(Pokemon pokemon) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

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
