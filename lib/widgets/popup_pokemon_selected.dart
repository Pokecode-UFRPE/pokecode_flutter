import 'package:flutter/material.dart';

class PopupPokemonSelected extends StatelessWidget {
  final String name;
  final int number_pokedex;
  final List<String> types;
  final bool capturado;
  final String pokeball;
  final String link;

  PopupPokemonSelected({
    required this.name,
    required this.number_pokedex,
    required this.types,
    required this.capturado,
    required this.link,
  }) : pokeball = capturado
            ? 'assets/icons/icon-pokeball.png'
            : 'assets/icons/icon-pokeball-white.png';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 40, top: 10),
                    height: 300,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(0, 248, 248, 248),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.7),
                          spreadRadius: 10,
                          blurRadius: 10,
                          blurStyle: BlurStyle.outer,
                        ),
                      ],
                    ),
                    child: Image.network(
                      link,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 40, top: 10),
                    height: 300,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      pokeball,
                      alignment: Alignment.topRight,
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    Text(
                      name.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'PressStart2P',
                      ),
                    ),
                    Text(
                      '#$number_pokedex',
                      style:
                          const TextStyle(fontSize: 15, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Wrap(
                  children: types.map((type) {
                    String atual = type.replaceAll('[', '').replaceAll(']', '');
                    return Image.asset(
                      'assets/images/tipos/$atual.png',
                    );
                  }).toList(),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Fechar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
