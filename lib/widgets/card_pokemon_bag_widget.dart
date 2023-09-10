import 'package:flutter/material.dart';
import 'package:pokecode/useCases/PokemonCaptureUseCase.dart';
import 'package:pokecode/widgets/pokemon_type_badge.dart';
import 'package:pokecode/widgets/popup_pokemon_selected.dart';

import '../models/Pokemon.dart';
import '../models/PokemonCapture.dart';

class CardPokemonBagWidget extends StatelessWidget {
  final int currentIndex;
  final Pokemon? pokemon;

  const CardPokemonBagWidget({
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
              width: 200,
              child: Card(
                color: Colors.white,
                elevation: 4.0,
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
                child: InkWell(
                  child: Stack(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1,
                        height: MediaQuery.of(context).size.width / 3.5,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Row(children: [
                                Text(
                                  '#${pokemon!.pokedexNumber.toString().padLeft(4, '0')}',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey.shade500,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ]),
                              SizedBox(height: 3),
                              Row(children: [
                                Text(
                                  pokemon!.name,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'PressStart2P',
                                  ),
                                ),
                              ]),
                              const SizedBox(
                                height: 10,
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                foregroundColor:
                                    const Color.fromARGB(255, 255, 191, 0),
                                radius: MediaQuery.of(context).size.width / 6.2, // Reduz o tamanho do CircleAvatar
                                child: ClipOval(
                                  child: Image.network(
                                    link,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: tipos.map((type) {
                                  return PokemonTypeBadge(type: type);
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.black,
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
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
                                capturado: false,
                                favorito: false,
                              ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
