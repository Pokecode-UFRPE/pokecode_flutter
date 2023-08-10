class Pokemon {
  final String id;
  bool capturado;
  bool favorito;

  Pokemon({
    required this.id,
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
      'favorito': favorito,
      'capturado': capturado,
    };
  }
}
