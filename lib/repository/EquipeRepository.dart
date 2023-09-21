 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../models/Pokemon.dart';
import '../models/equipe.dart';

class EquipeRepository {

  void saveEquipe(Equipe equipe) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('teams')
        .doc(equipe.id)
        .set(equipe.toMap());
  }
  Future<List<Equipe>> findAllEquipes() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('teams')
        .get();

    List<Equipe> equipes = [];

    for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
      Equipe equipe = Equipe.fromMap(data);
      equipes.add(equipe);
    }

    return equipes;
  }

  void deleteById(String id) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('teams')
        .doc(id).delete();
  }

}
