import 'package:flutter/material.dart';
import 'package:pokecode/repository/PokemonRepository.dart';

import '../../models/Pokemon.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/bottom_navigation_bar_widget.dart';
import '../../widgets/card_pokemon_horizontal.dart';

class PokedexScreen extends StatefulWidget {
  const PokedexScreen({super.key});

  @override
  _PokedexScreenState createState() => _PokedexScreenState();
}

class _PokedexScreenState extends State<PokedexScreen> {
  final PokemonRepository _pokemonRepository = PokemonRepository();
  String _valorInput = "";
  List _filtroEValor = ['', ''];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        currentIndex: 0,
        valorInput: _valorInput,
        filtroEValorAppBar: _filtroEValor,
        onInputChanged: (newValue) {
          setState(() {
            _valorInput = newValue;
          });
        },
        onPopupChanged: (newValue) {
          setState(() {
            _filtroEValor = newValue;
          });
        },
      ),
      body: Stack(children: [selecaoWidget(), closeFilter()]),
      bottomNavigationBar: BottomNavigationBarWidget(
        currentIndex: 1,
      ),
    );
  }

  Widget selecaoWidget() {
    if (_filtroEValor[0].isNotEmpty) {
      return pokeFilterString(_filtroEValor[1], _filtroEValor[0]);
    } else {
      if (_valorInput.isNotEmpty) {
        return pokeInput(_valorInput);
      } else {
        return pokeComum();
      }
    }
  }

  Widget pokeComum() {
    return ListView.builder(
      itemCount: 899,
      itemBuilder: (context, index) {
        return FutureBuilder<Pokemon?>(
          future: _pokemonRepository.getPokemon(index + 1),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 20.0),
                child:
                    Image.asset('assets/images/spinner_ball.gif', height: 40),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              Pokemon? pk = snapshot.data;
              if (pk != null) {
                return CardPokemonHorizontalWidget(
                    currentIndex: 0, pokemon: pk);
              } else {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 20.0),
                  child:
                      Image.asset('assets/images/spinner_ball.gif', height: 40),
                );
              }
            }
          },
        );
      },
    );
  }

  Widget pokeInput(String aux) {
    return FutureBuilder<List<Pokemon>>(
      future: _pokemonRepository.getPokemonsInput(aux),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 20.0),
            child: Image.asset('assets/images/spinner_ball.gif', height: 40),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Pokemon>? pokemons = snapshot.data;
          if (pokemons != null && pokemons.isNotEmpty) {
            return ListView.builder(
              itemCount: pokemons.length,
              itemBuilder: (context, index) {
                return CardPokemonHorizontalWidget(
                  currentIndex: index,
                  pokemon: pokemons[index],
                );
              },
            );
          } else {
            return const Text('No results found.');
          }
        }
      },
    );
  }

  Widget pokeFilterString(String aux, String tipoDeBusca) {
    return FutureBuilder<List<Pokemon>>(
      future: _pokemonRepository.getPokemonsFiltroString(aux, tipoDeBusca),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 20.0),
            child: Image.asset('assets/images/spinner_ball.gif', height: 40),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Pokemon>? pokemon = snapshot.data;
          if (pokemon != null && pokemon.isNotEmpty) {
            return ListView.builder(
              itemCount: pokemon.length,
              itemBuilder: (context, index) {
                return CardPokemonHorizontalWidget(
                  currentIndex: index,
                  pokemon: pokemon[index],
                );
              },
            );
          } else {
            return const Text('No results found.');
          }
        }
      },
    );
  }

  Widget closeFilter() {
    return (_valorInput.isNotEmpty || _filtroEValor[0].isNotEmpty)
        ? Positioned(
            bottom: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    _valorInput = '';
                    _filtroEValor = ['', ''];
                  });
                },
                backgroundColor: Colors.black,
                child: const Icon(Icons.search_off),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
