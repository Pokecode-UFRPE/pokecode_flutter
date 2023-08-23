import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/PokemonModel.dart';

class PokemonRepository {
  Future<PokemonModel> adicionarPokemon(PokemonModel pokemon) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('bag')
        .doc(pokemon.id)
        .set(pokemon.toMap());

    return pokemon;
  }

  Future<PokemonModel?> findById(String pokemonId) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('bag')
        .doc(pokemonId)
        .get();

    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
      List<String> types = (data['types'] as List<dynamic>).cast<String>();
      return PokemonModel(
        id: data['id'],
        types: types,
        name: data['name'],
        image: data['image'],
        favorito: data['favorito'],
        capturado: data['capturado'],
      );
    } else {
      return null;
    }
  }

  Future<void> updatePokemon(PokemonModel pokemon) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('bag')
        .doc(pokemon.id.toString())
        .update(pokemon.toMap())
        .catchError(
          (error) => throw Exception("Erro ao atualizar Pokémon: $error"),
        );
  }

  Future<List<PokemonModel>> findByCapturados() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('bag')
        .where('capturado', isEqualTo: true)
        .get();

    List<PokemonModel> capturados = [];
    for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
      List<String> types = (data['types'] as List<dynamic>).cast<String>();
      capturados.add(
        PokemonModel(
          id: data['id'],
          types: types,
          name: data['name'],
          image: data['image'],
          favorito: data['favorito'],
          capturado: data['capturado'],
        ),
      );
    }
    return capturados;
  }
}
