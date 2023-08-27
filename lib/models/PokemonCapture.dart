class PokemonCapture {
  final String id;
  bool capturado;
  bool favorito;
  int gosta;

  PokemonCapture({
    required this.id,
    required this.gosta,
    required this.capturado,
    required this.favorito,
  });

  void toggleFavoritar() {
    favorito = !favorito;
  }

  void toggleCapturar() {
    capturado = !capturado;
  }

  void changeGosta(int index) {
    gosta = index;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'favorito': favorito,
      'capturado': capturado,
      'gosta': gosta,
    };
  }
}
