import 'package:flutter/material.dart';
import 'package:pokecode/widgets/popup_pokemon_selected.dart';

class CardPokemonHorizontalWidget extends StatelessWidget {
  final int currentIndex;
  final String img_pokemon;

  CardPokemonHorizontalWidget({required this.currentIndex, required this.img_pokemon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return PopupPokemonSelected(
                img_pokemon: img_pokemon,
                name: 'Cindaquill',
                number_pokedex: '0155',
                types: ['fire', 'bug'],
                capturado: true,
              );
            },
          );
        },
        child: Center(
          child: Card(
            color: Colors.white,
            elevation: 4.0,
            shadowColor: Colors.black,
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
                            '#0155',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          const SizedBox(height: 1),
                          Text(
                            'Cindaquill',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset('assets/images/tipos/fire.png', height: 22),
                              SizedBox(width: 5),
                              Image.asset('assets/images/tipos/bug.png', height: 22),
                            ],
                          ),
                        ],
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white, 
                      radius: MediaQuery.of(context).size.width / 6,
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/$img_pokemon.png',
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ), 
      ),
    );
  }
}
