import 'package:flutter/material.dart';
import 'package:pokecode/widgets/pokemon_type_badge.dart';

class PopupPokemonSelected extends StatefulWidget {
  final String name;
  final int number_pokedex;
  final List<String> types;
  bool capturado;
  String pokeball;
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
  _PopupPokemonSelectedState createState() => _PopupPokemonSelectedState();
}

class _PopupPokemonSelectedState extends State<PopupPokemonSelected> {
  void changeCapturado() {
    setState(() {
      widget.capturado = !widget.capturado;
      if (widget.capturado) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                'O pokémon foi adicionado a sua bag',
                style: TextStyle(color: Colors.white),
              )),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text('O pokémon foi removido da sua bag',
                style: TextStyle(color: Colors.white)),
          ),
        );
      }
      widget.pokeball = widget.capturado
          ? 'assets/icons/icon-pokeball.png'
          : 'assets/icons/icon-pokeball-white.png';
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () => Navigator.of(context).pop(),
      child: Dialog(
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
                        widget.link,
                      ),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      margin: const EdgeInsets.only(top: 10),
                      height: 80,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          changeCapturado();
                          // Ação que será executada quando o botão for pressionado
                          print('Botão pressionado!');
                        },
                        child: Image.asset(
                          widget.pokeball,
                          // Coloque o caminho da imagem "pokeball" aqui
                          alignment: Alignment.topRight,
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      Text(
                        widget.name.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'PressStart2P',
                        ),
                      ),
                      Text(
                        '#${widget.number_pokedex}',
                        style: const TextStyle(
                            fontSize: 15, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Wrap(
                    children: widget.types.map((type) {
                      return PokemonTypeBadge(type: type);
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
