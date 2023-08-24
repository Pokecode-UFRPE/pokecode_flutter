import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/Pokemon.dart';

class PokemonRepository {
  Future<PokemonCapture> adicionarPokemon(PokemonCapture pokemon) async {
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
          favorito: data['favorito'],
          capturado: data['capturado']);
    } else {
      return null;
    }
  }

  Future<void> updatePokemon(PokemonCapture pokemon) async {
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
