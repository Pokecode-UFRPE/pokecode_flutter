import 'package:flutter/material.dart';

class Equipe {
  String id;
  String name;
  String pokemon1;
  String pokemon2;
  String pokemon3;

  Equipe(
    @required this.id,
    @required this.name,
    @required this.pokemon1,
    @required this.pokemon2,
    @required this.pokemon3,
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'pokemon1': pokemon1,
      'pokemon2': pokemon2,
      'pokemon3': pokemon3,
    };
  }
  factory Equipe.fromMap(Map<String, dynamic> map) {
    return Equipe(
      map['id'],
      map['name'],
      map['pokemon1'],
      map['pokemon2'],
      map['pokemon3'],
    );
  }
}
