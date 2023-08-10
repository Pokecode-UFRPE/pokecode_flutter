import 'package:flutter/material.dart';
import 'package:pokecode/widgets/pokemon_type_badge.dart';

import '../models/Pokemon.dart';
import '../repository/PokemonRepository.dart';

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
  _PopupPokemonSelectedState createState() =>
      _PopupPokemonSelectedState(number_pokedex.toString());
}

class _PopupPokemonSelectedState extends State<PopupPokemonSelected> {
  final String id;
  bool isLoading = true;
  bool favorito = false;
  final PokemonRepository pokemonRepository = PokemonRepository();

  _PopupPokemonSelectedState(this.id);

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    pokemonRepository.findById(id).then((pokemon) {
      if (pokemon != null) {
        setState(() {
          widget.capturado = pokemon.capturado;
          favorito = pokemon.favorito;
          widget.pokeball = widget.capturado
              ? 'assets/icons/icon-pokeball.png'
              : 'assets/icons/icon-pokeball-white.png';
        });
      }
      setState(() {
        isLoading = false;
      });
    });
  }

  void changeCapturado() async {
    setState(() {
      widget.capturado = !widget.capturado;
      widget.pokeball = widget.capturado
          ? 'assets/icons/icon-pokeball.png'
          : 'assets/icons/icon-pokeball-white.png';
    });
    Pokemon? pokemon = await pokemonRepository.findById(id);
    if (pokemon != null) {
      pokemon = Pokemon(favorito: widget.capturado, capturado: true, id: id);
      PokemonRepository().updatePokemon(pokemon);
    } else {
      pokemon = Pokemon(favorito: widget.capturado, capturado: true, id: id);
      PokemonRepository().adicionarPokemon(pokemon);
    }
    try {
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
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'Erro',
              style: TextStyle(color: Colors.white),
            )),
      );
    }
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
            child: isLoading
                ? Image.asset('assets/images/spinner_ball.gif', height: 40)
                : Column(
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
                      PokeballTools(
                        capturado: widget.capturado,
                        favorito: favorito,
                        id: id,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class PokeballTools extends StatefulWidget {
  final bool capturado;
  bool favorito;
  String pokeball;
  final String id;

  PokeballTools({
    required this.capturado,
    required this.id,
    required this.favorito,
  }) : pokeball = capturado
            ? 'assets/icons/icon-pokeball.png'
            : 'assets/icons/icon-pokeball-white.png';

  @override
  _PokeballToolsState createState() => _PokeballToolsState();
}

class _PokeballToolsState extends State<PokeballTools> {
  final PokemonRepository pokemonRepository = PokemonRepository();

  void favoritar() async {
    setState(() {
      widget.favorito = !widget.favorito;
    });
    pokemonRepository.findById(widget.id).then((pokemon) {
      if (pokemon != null) {
        pokemon = Pokemon(
            favorito: widget.favorito,
            capturado: widget.capturado,
            id: widget.id);
        PokemonRepository().updatePokemon(pokemon);
      } else {
        pokemon = Pokemon(
            favorito: widget.favorito,
            capturado: widget.capturado,
            id: widget.id);
        PokemonRepository().adicionarPokemon(pokemon);
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
            ],
          ),
        ),
      ],
    );
  }
}
