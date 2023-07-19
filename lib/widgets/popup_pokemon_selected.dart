import 'package:flutter/material.dart';

class PopupPokemonSelected extends StatelessWidget {
  final String img_pokemon;
  final String name;
  final List<String> types;
  final String number_pokedex;

  PopupPokemonSelected(
      {required this.img_pokemon,
      required this.name,
      required this.types,
      required this.number_pokedex});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(25.0),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 40),
                height: 300,
                decoration: BoxDecoration(
                    color: Color(0xF8F8F8),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 10,
                          blurRadius: 10,
                          offset: Offset(0, 0),
                          blurStyle: BlurStyle.outer)
                    ]),
                child: Image.asset(
                  'assets/images/$img_pokemon.png',
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 5),
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
                    Text('#$number_pokedex',
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black54
                    ),),
                  ],
                ),
              ),
              Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: types.length,
                  itemBuilder: (context, index) {
                    String atual = types[index].replaceAll('[', '').replaceAll(']', '');
                    return 
                        Image.asset(
                            'assets/images/tipos/$atual.png'
                          );
                  },
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
