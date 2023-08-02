import 'package:flutter/material.dart';
import 'package:pokecode/widgets/popup_pokemon_selected.dart';
import '../services/db_firestore.dart';

// ignore: must_be_immutable
class CardPokemonHorizontalWidget extends StatelessWidget {
  final int currentIndex;
  Pokemon? pokemon;

  CardPokemonHorizontalWidget(
      {super.key, required this.currentIndex, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    String link = '';
    if (pokemon!.pokedex_number < 10) {
      link =
          'https://raw.githubusercontent.com/HybridShivam/Pokemon/master/assets/images/00${pokemon!.pokedex_number}.png';
    } else if ((pokemon!.pokedex_number < 100)) {
      link =
          'https://raw.githubusercontent.com/HybridShivam/Pokemon/master/assets/images/0${pokemon!.pokedex_number}.png';
    } else {
      link =
          'https://raw.githubusercontent.com/HybridShivam/Pokemon/master/assets/images/${pokemon!.pokedex_number}.png';
    }
    List<String> tipos = pokemon!.typing.split("~");

    return Center(
      child: Card(
          color: Colors.white,
          elevation: 4.0,
          shadowColor: Colors.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
          child: InkWell(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.05,
              height: MediaQuery.of(context).size.width / 4.5,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '#${pokemon!.pokedex_number}',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          const SizedBox(height: 1),
                          Text(
                            pokemon!.name,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'PressStart2P',
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                            Wrap(
                              children: tipos.map((type) {
                                String atual = type.replaceAll('[', '').replaceAll(']', '');
                                return Image.asset(
                                  'assets/images/tipos/$atual.png',
                                );
                              }).toList(),
                            ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color.fromARGB(255, 255, 191, 0),
                      radius: MediaQuery.of(context).size.width / 6,
                      child: ClipOval(
                        child: Image.network(
                          link,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
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
                      name: pokemon!.name,
                      number_pokedex: pokemon!.pokedex_number,
                      types: tipos,
                      capturado: true,
                      link: link);
                },
              );
            },
          )),
    );
  }
}
