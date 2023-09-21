import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/PokemonCapture.dart';

class PokecenterRepository {
  Future<PokemonCapture> addPokemon(PokemonCapture pokemon) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    pokemon.pokecenter = true;
    print(pokemon.toMap());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('bag')
        .doc(pokemon.id)
        .set(pokemon.toMap());

    return pokemon;
  }

  void remove(String pokemonId) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('bag')
        .doc(pokemonId)
        .get();

    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
      PokemonCapture pokemon = PokemonCapture(
          id: data['id'],
          gosta: data['gosta'],
          pokecenter: false,
          favorito: data['favorito'],
          capturado: data['capturado']);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('bag')
          .doc(pokemonId)
          .update(pokemon.toMap());
    }
  }

  Future<List<PokemonCapture>> findAll() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('bag')
        .where('pokecenter', isEqualTo: true)
        .get();

    List<PokemonCapture> capturedPokemons = [];

    for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
      capturedPokemons.add(PokemonCapture(
        id: data['id'],
        pokecenter: data['pokecenter'],
        gosta: data['gosta'],
        favorito: data['favorito'],
        capturado: data['capturado'],
      ));
    }

    return capturedPokemons;
  }
}
