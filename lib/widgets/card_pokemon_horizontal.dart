import 'package:flutter/material.dart';
import 'package:pokecode/models/PokemonCapture.dart';
import 'package:pokecode/useCases/PokemonCaptureUseCase.dart';
import 'package:pokecode/widgets/pokemon_type_badge.dart';
import 'package:pokecode/widgets/popup_pokemon_selected.dart';

import '../models/Pokemon.dart';

class CardPokemonHorizontalWidget extends StatefulWidget {
  final int currentIndex;
  final Pokemon? pokemon;

  const CardPokemonHorizontalWidget({
    Key? key,
    required this.currentIndex,
    required this.pokemon,
  }) : super(key: key);

  @override
  _CardPokemonHorizontalWidgetState createState() =>
      _CardPokemonHorizontalWidgetState();
}

class _CardPokemonHorizontalWidgetState
    extends State<CardPokemonHorizontalWidget> {
  PokemonCapture _pokemonCapture = PokemonCapture(
      id: "1", gosta: 0, pokecenter: false, capturado: false, favorito: false);
  String link = "";
  String? _pokeball;
  List<String> tipos = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      PokemonCaptureUseCase()
          .getPokemon(widget.pokemon!.pokedexNumber.toString())
          .then((value) => _pokemonCapture = value);
      _pokeball =
          _pokemonCapture.capturado ? 'assets/icons/icon-pokeball.png' : "";
      link =
          'https://raw.githubusercontent.com/HybridShivam/Pokemon/master/assets/images/${widget.pokemon!.pokedexNumber.toString().padLeft(3, '0')}.png';
      tipos = widget.pokemon!.typing.split("~");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 10),
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
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '#${widget.pokemon!.pokedexNumber.toString().padLeft(4, '0')}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            widget.pokemon!.name,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'PressStart2P',
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: tipos.map((type) {
                              return PokemonTypeBadge(type: type);
                            }).toList(),
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
                          fit: BoxFit.contain,
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
                    types: tipos,
                    pokemonz: widget.pokemon!,
                    pokemonCapture: _pokemonCapture,
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
