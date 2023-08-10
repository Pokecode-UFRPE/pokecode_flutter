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
  bool _showActions = false;

  void changeCapturado() {
    setState(() {
      widget.capturado = !widget.capturado;
      _showActions = !_showActions;
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
                Container(
                  margin: const EdgeInsets.only(bottom: 40, top: 10),
                  height: 300,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(0, 248, 248, 248),
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
                  child: Stack(
                    children: [
                      Container(
                        alignment: Alignment.center,
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
                          },
                          child: Image.asset(
                            widget.pokeball,
                            // Coloque o caminho da imagem "pokeball" aqui
                            alignment: Alignment.topRight,
                          ),
                        ),
                      ),
                    ],
                  ),
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
                        '#${widget.number_pokedex.toString().padLeft(4, '0')}',
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
                PokeballTools(capturado: false),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PokeballTools extends StatefulWidget {
  bool capturado;
  bool favorito = false;
  int gosto = 0;
  String pokeball;

  PokeballTools({
    required this.capturado,
  }) : pokeball = capturado
            ? 'assets/icons/icon-pokeball.png'
            : 'assets/icons/icon-pokeball-white.png';

  @override
  _PokeballToolsState createState() => _PokeballToolsState();
}

class _PokeballToolsState extends State<PokeballTools> {
  // Funções que representam as ações que podem ser selecionadas
  void favoritar() {
    setState(() {
      widget.favorito = !widget.favorito;
    });
  }

  void gosto() {
    setState(() {
      if (widget.gosto == 2) {
        widget.gosto = 0;
      } else {
        widget.gosto = 2;
      }
    });
  }

  void naoGosto() {
    setState(() {
      if (widget.gosto == 3) {
        widget.gosto = 0;
      } else {
        widget.gosto = 3;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 150,
          height: 30,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.7),
                spreadRadius: 3,
                blurRadius: 5,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  favoritar();
                },
                child: Icon(
                  widget.favorito
                      ? Icons.favorite_sharp
                      : Icons.favorite_border_sharp,
                  color: widget.favorito ? Colors.red : null,
                ),
              ),
              GestureDetector(
                onTap: () {
                  gosto();
                },
                child: Icon(
                  widget.gosto == 2
                      ? Icons.thumb_up_alt_rounded
                      : Icons.thumb_up_alt_outlined,
                ),
              ),
              GestureDetector(
                onTap: () {
                  naoGosto();
                },
                child: Icon(
                  widget.gosto == 3
                      ? Icons.thumb_down_alt_rounded
                      : Icons.thumb_down_alt_outlined,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
