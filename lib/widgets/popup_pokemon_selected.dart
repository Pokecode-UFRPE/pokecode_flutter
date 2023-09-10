import 'package:flutter/material.dart';
import 'package:pokecode/models/PokemonCapture.dart';
import 'package:pokecode/repository/PokemonUserRepository.dart';
import 'package:pokecode/widgets/pokemon_type_badge.dart';

import '../models/Pokemon.dart';

class PopupPokemonSelected extends StatefulWidget {
  final List<String> types;
  String pokeball;
  PokemonCapture pokemonCapture;
  final String link;
  final Pokemon pokemonz;

  PopupPokemonSelected({
    super.key,
    required this.pokemonCapture,
    required this.types,
    required this.link,
    required this.pokemonz,
  }) : pokeball = pokemonCapture.capturado
            ? 'assets/icons/icon-pokeball.png'
            : 'assets/icons/icon-pokeball-white.png';

  @override
  // ignore: library_private_types_in_public_api
  _PopupPokemonSelectedState createState() => _PopupPokemonSelectedState();
}

class _PopupPokemonSelectedState extends State<PopupPokemonSelected> {
  final PokemonUserRepository _pokemonRepository = PokemonUserRepository();

  void changeCapturado() {
    setState(() {
      bool estePokemonJaHaviaSidoCapturado = false;
      _pokemonRepository.findById(widget.pokemonCapture.id).then((value) => {
            if (value != null) {estePokemonJaHaviaSidoCapturado = true}
          });
      widget.pokemonCapture.capturado = !widget.pokemonCapture.capturado;
      if (estePokemonJaHaviaSidoCapturado) {
        _pokemonRepository.updatePokemon(widget.pokemonCapture);
      } else {
        _pokemonRepository.addPokemon(widget.pokemonCapture);
      }

      if (widget.pokemonCapture.capturado) {
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
      widget.pokeball = widget.pokemonCapture.capturado
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
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  height: 300,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 248, 248, 248),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color:
                            Color.fromARGB(255, 130, 122, 122).withOpacity(0.7),
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
                        height: 70,
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
                        widget.pokemonz.name.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'PressStart2P',
                        ),
                      ),
                      Text(
                        '#${widget.pokemonz.pokedexNumber.toString().padLeft(4, '0')}',
                        style: const TextStyle(
                            fontSize: 15, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Alterar Nome do Pokémon',
                              style: TextStyle(fontFamily: 'PressStart2P')),
                          content: renomear_pokemon(
                            currentName: widget.pokemonz.name,
                            onNameChanged: (newName) {
                              setState(() {
                                widget.pokemonz.name = newName;
                              });
                              Navigator.of(context).pop();
                            },
                          ),
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                    width: 100,
                    alignment: Alignment.center,
                    child: const Text(
                      'Alterar Nome',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 8,
                        fontFamily: 'PressStart2P',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                PokeballTools(pokemonCapture: widget.pokemonCapture),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Wrap(
                    children: widget.types.map((type) {
                      return PokemonTypeBadge(type: type);
                    }).toList(),
                  ),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Image.asset(
                              'assets/icons/color.png',
                              scale: 2.5,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              widget.pokemonz.primaryColor,
                              textScaleFactor: 0.8,
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Column(
                          children: [
                            Image.asset(
                              'assets/icons/height.png',
                              scale: 2.5,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${(widget.pokemonz.height / 10).toString()}m',
                              textScaleFactor: 0.8,
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Column(
                          children: [
                            Image.asset(
                              'assets/icons/weight.png',
                              scale: 2.5,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${(widget.pokemonz.weight / 10).toString()}Kg',
                              textScaleFactor: 0.8,
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Column(
                          children: [
                            Image.asset(
                              'assets/images/shapes/${widget.pokemonz.shape}.webp',
                              scale: 1.8,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              widget.pokemonz.shape,
                              textScaleFactor: 0.8,
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/hp.png',
                          scale: 1.5,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Stack(
                          children: [
                            Container(
                              width: 190,
                              height: 9,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 186, 181, 181),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            Container(
                              width: ((widget.pokemonz.hp / 254) * 100) *
                                  (190 / 100),
                              height: 9,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 229, 19, 19),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/attack.png',
                          scale: 1.5,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Stack(
                          children: [
                            Container(
                              width: 190,
                              height: 9,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 186, 181, 181),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            Container(
                              width: ((widget.pokemonz.attack / 176) * 100) *
                                  (190 / 100),
                              height: 9,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 229, 131, 19),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/defense.png',
                          scale: 1.5,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Stack(
                          children: [
                            Container(
                              width: 190,
                              height: 9,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 186, 181, 181),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            Container(
                              width: ((widget.pokemonz.defense / 225) * 100) *
                                  (190 / 100),
                              height: 9,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 19, 120, 229),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/speed.png',
                          scale: 1.5,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Stack(
                          children: [
                            Container(
                              width: 190,
                              height: 9,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 186, 181, 181),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            Container(
                              width: ((widget.pokemonz.speed / 195) * 100) *
                                  (190 / 100),
                              height: 9,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 162, 19, 229),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    markEvolui(widget.pokemonz.canEvolve),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    elevation: 8,
                    shape: const CircleBorder(
                      side: BorderSide(
                          color: Color.fromARGB(
                              128, 0, 0, 0)), // Borda preta clarinha
                    ),
                  ),
                  child: const Padding(
                    padding:
                        EdgeInsets.all(10.0), // Espaçamento interno do ícone
                    child: Icon(
                      Icons.close, // Ícone "X"
                      size: 24, // Tamanho do ícone
                      color: Colors.black54, // Cor do ícone preto clarinho
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class PokeballTools extends StatefulWidget {
  PokemonCapture pokemonCapture;
  String pokeball;

  PokeballTools({
    super.key,
    required this.pokemonCapture,
  }) : pokeball = pokemonCapture.capturado
            ? 'assets/icons/icon-pokeball.png'
            : 'assets/icons/icon-pokeball-white.png';

  @override
  // ignore: library_private_types_in_public_api
  _PokeballToolsState createState() => _PokeballToolsState();
}

class _PokeballToolsState extends State<PokeballTools> {
  final PokemonUserRepository _pokemonRepository = PokemonUserRepository();

  // Funções que representam as ações que podem ser selecionadas
  void favoritar() {
    setState(() {
      widget.pokemonCapture.favorito = !widget.pokemonCapture.favorito;
    });
    _pokemonRepository.updatePokemon(widget.pokemonCapture);
  }

  void gosto() {
    setState(() {
      if (widget.pokemonCapture.gosta == 2) {
        widget.pokemonCapture.gosta = 0;
      } else {
        widget.pokemonCapture.gosta = 2;
      }
      _pokemonRepository.updatePokemon(widget.pokemonCapture);
    });
  }

  void naoGosto() {
    setState(() {
      if (widget.pokemonCapture.gosta == 3) {
        widget.pokemonCapture.gosta = 0;
      } else {
        widget.pokemonCapture.gosta = 3;
      }
      _pokemonRepository.updatePokemon(widget.pokemonCapture);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 190,
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
                  widget.pokemonCapture.favorito
                      ? Icons.favorite_sharp
                      : Icons.favorite_border_sharp,
                  color: widget.pokemonCapture.favorito ? Colors.red : null,
                ),
              ),
              GestureDetector(
                onTap: () {
                  gosto();
                },
                child: Icon(
                  widget.pokemonCapture.gosta == 2
                      ? Icons.thumb_up_alt_rounded
                      : Icons.thumb_up_alt_outlined,
                ),
              ),
              GestureDetector(
                onTap: () {
                  naoGosto();
                },
                child: Icon(
                  widget.pokemonCapture.gosta == 3
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

Widget markEvolui(bool evolui) {
  if (evolui) {
    return const SizedBox(
      width: 220,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Pode evoluir",
            style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 12,
              fontFamily: 'PressStart2P',
            ),
          ),
          SizedBox(width: 10),
          Icon(
            Icons.auto_awesome,
            color: Colors.black,
          ),
        ],
      ),
    );
  } else {
    return Container(); // Retorna um Container vazio caso não evolua
  }
}
