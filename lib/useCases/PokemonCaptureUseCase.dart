import 'package:pokecode/models/PokemonCapture.dart';
import 'package:pokecode/repository/PokemonUserRepository.dart';

class PokemonCaptureUseCase {
  final PokemonUserRepository _pokemonRepository = PokemonUserRepository();

  Future<PokemonCapture> getPokemon(String pokemonId) async {
    PokemonCapture? value = await _pokemonRepository.findById(pokemonId);

    if (value != null) {
      return value;
    } else {
      return PokemonCapture(
          id: pokemonId,
          gosta: 0,
          pokecenter: false,
          capturado: false,
          favorito: false);
    }
  }
}
