class PokemonModel {
  final String id;
  final String name;
  final String image;
  final List<String> types;
  bool capturado;
  bool favorito;

  PokemonModel({
    required this.id,
    required this.types,
    required this.name,
    required this.image,
    required this.capturado,
    required this.favorito,
  });

  void toggleFavoritar() {
    favorito = !favorito;
  }

  void toggleCapturar() {
    capturado = !capturado;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'types': types,
      'image': image,
      'favorito': favorito,
      'capturado': capturado,
    };
  }

  factory PokemonModel.fromMap(Map<String, dynamic> map) {
    return PokemonModel(
      types: map['types'],
      id: map['id'],
      name: map['name'],
      image: map['image'],
      favorito: map['favorito'],
      capturado: map['capturado'],
    );
  }
}
