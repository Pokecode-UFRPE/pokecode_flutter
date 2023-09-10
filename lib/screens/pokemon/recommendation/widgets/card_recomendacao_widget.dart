import 'package:flutter/material.dart';
import 'package:pokecode/useCases/PokemonCaptureUseCase.dart';
import 'package:pokecode/widgets/popup_pokemon_selected.dart';

import '../../../../models/Pokemon.dart';
import '../../../../models/PokemonCapture.dart';

class CardRecomendacaoWidget extends StatelessWidget {
  final int currentIndex;
  Pokemon? pokemon;

  CardRecomendacaoWidget({
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
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final pokemonCapture = snapshot.data!;
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width / 3,
            child: Card(
              clipBehavior: Clip.hardEdge,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/bg_recomendacoes/star.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned.fill(
                    child: Image.network(link),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: const Color.fromARGB(255, 255, 255, 255),
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
