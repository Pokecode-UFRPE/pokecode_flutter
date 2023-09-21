class PokemonCapture {
  final String id;
  bool capturado;
  bool favorito;
  bool pokecenter;
  int gosta;

  PokemonCapture({
    required this.id,
    required this.gosta,
    required this.pokecenter,
    required this.capturado,
    required this.favorito,
  });

  void toggleFavoritar() {
    favorito = !favorito;
  }

  void togglePokecenter() {
    pokecenter = !pokecenter;
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
      'pokecenter': pokecenter,
      'capturado': capturado,
      'gosta': gosta,
    };
  }
}
