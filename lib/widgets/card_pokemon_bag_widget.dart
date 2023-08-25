import 'package:flutter/material.dart';
import 'package:pokecode/widgets/pokemon_type_badge.dart';
import 'package:pokecode/widgets/popup_pokemon_selected.dart';

import '../services/db_firestore.dart';

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
    String link = '';

    if (pokemon!.pokedexNumber < 10) {
      link =
          'https://raw.githubusercontent.com/HybridShivam/Pokemon/master/assets/images/00${pokemon!.pokedexNumber}.png';
    } else if (pokemon!.pokedexNumber < 100) {
      link =
          'https://raw.githubusercontent.com/HybridShivam/Pokemon/master/assets/images/0${pokemon!.pokedexNumber}.png';
    } else {
      link =
          'https://raw.githubusercontent.com/HybridShivam/Pokemon/master/assets/images/${pokemon!.pokedexNumber}.png';
    }
    List<String> tipos = pokemon!.typing.split("~");

    return Center(
      child: SizedBox(
        height: 230,
        width: 182,
        child: Card(
          color: Colors.white,
          elevation: 4.0,
          shadowColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
          child: InkWell(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1,
              height: MediaQuery.of(context).size.width / 3.5,
              child: Padding(
                padding: const EdgeInsets.all(12),
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
                      foregroundColor: const Color.fromARGB(255, 255, 191, 0),
                      radius: MediaQuery.of(context).size.width / 6,
                      child: ClipOval(
                        child: Image.network(
                          link,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
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
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return PopupPokemonSelected(
                    types: tipos,
                    pokemonz: pokemon!,
                    capturado: false,
                    link: link,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
