import 'package:flutter/material.dart';
import 'package:pokecode/useCases/PokemonCaptureUseCase.dart';
import 'package:pokecode/widgets/popup_pokemon_selected.dart';

import '../models/Pokemon.dart';
import '../models/PokemonCapture.dart';

class CardPokemonPokecenterWidget extends StatelessWidget {
  final int currentIndex;
  final Pokemon? pokemon;

  const CardPokemonPokecenterWidget({
    Key? key,
    required this.currentIndex,
    required this.pokemon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PokemonCapture>(
      future:
          PokemonCaptureUseCase().getPokemon(pokemon!.pokedexNumber.toString()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Erro: ${snapshot.error}');
        } else {
          final pokemonCapture = snapshot.data;

          String link =
              'https://raw.githubusercontent.com/HybridShivam/Pokemon/master/assets/images/${pokemon!.pokedexNumber.toString().padLeft(3, '0')}.png';
          List<String> tipos = pokemon!.typing.split("~");

          return Center(
            child: SizedBox(
              height: 270,
              width: 190,
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1,
                height: MediaQuery.of(context).size.width / 3.5,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  // Cor da sombra
                                  spreadRadius: 2,
                                  // Raio de propagação da sombra
                                  blurRadius: 5,
                                  // Raio de desfoque da sombra
                                  offset: Offset(0,
                                      2), // Deslocamento da sombra (horizontal, vertical)
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              foregroundColor:
                                  const Color.fromARGB(255, 255, 191, 0),
                              radius: MediaQuery.of(context).size.width / 6,
                              child: ClipOval(
                                child: Image.network(
                                  link,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return PopupPokemonSelected(
                                  types: tipos,
                                  pokemonz: pokemon!,
                                  link: link,
                                  pokemonCapture: snapshot.data ??
                                      PokemonCapture(
                                        id: pokemon!.pokedexNumber.toString(),
                                        gosta: 0,
                                        pokecenter: true,
                                        capturado: true,
                                        favorito: false,
                                      ),
                                );
                              },
                            );
                          }),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
