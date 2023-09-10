import 'package:flutter/material.dart';
import 'package:pokecode/useCases/PokemonCaptureUseCase.dart';
import 'package:pokecode/widgets/popup_pokemon_selected.dart';

import '../../../../models/Pokemon.dart';
import '../../../../models/PokemonCapture.dart';

class CardSimplesRecomendacaoWidget extends StatelessWidget {
  final int currentIndex;
  Pokemon? pokemon;

  CardSimplesRecomendacaoWidget({
    super.key,
    required this.currentIndex,
    required this.pokemon,
  });

  @override
  Widget build(BuildContext context) {
    String link =
        'https://raw.githubusercontent.com/HybridShivam/Pokemon/master/assets/images/${pokemon!.pokedexNumber.toString().padLeft(3, '0')}.png';

    List<String> tipos = pokemon!.typing.split("~");

    return FutureBuilder<PokemonCapture>(
      future:
          PokemonCaptureUseCase().getPokemon(pokemon!.pokedexNumber.toString()),
      builder: (BuildContext context, AsyncSnapshot<PokemonCapture> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 20.0),
            child: Image.asset('assets/images/spinner_ball.gif', height: 40),
          );
        } else if (snapshot.hasError) {
          // Lidar com erros se ocorrerem
          return Text('Error: ${snapshot.error}');
        } else {
          // Dados carregados com sucesso, construir o widget
          final pokemonCapture = snapshot.data!;
          return SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            height: MediaQuery.of(context).size.height / 3,
            child: Card(
              clipBehavior: Clip.hardEdge,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/bg_recomendacoes/${tipos[0].toLowerCase()}.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned.fill(
                    child: Image.network(
                      link,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Color.fromARGB(255, 255, 255, 255),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return PopupPokemonSelected(
                              types: tipos,
                              link: link,
                              pokemonz: pokemon!,
                              pokemonCapture: pokemonCapture,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
