import 'package:flutter/material.dart';

import '../../models/Pokemon.dart';
import '../../models/PokemonCapture.dart';
import '../../repository/PokemonRepository.dart';
import '../../repository/PokemonUserRepository.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/bottom_navigation_bar_widget.dart';
import '../../widgets/card_pokemon_bag_widget.dart';

class BagScreen extends StatefulWidget {
  @override
  _BagScreenState createState() => _BagScreenState();
}

class _BagScreenState extends State<BagScreen> {
  String _inputValue = "";
  List _filterAndValue = ['', ''];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        currentIndex: 0,
        valorInput: _inputValue,
        filtroEValorAppBar: _filterAndValue,
        onInputChanged: (newValue) {
          setState(() {
            _inputValue = newValue;
          });
        },
        onPopupChanged: (newValue) {
          setState(() {
            _filterAndValue = newValue;
          });
        },
      ),
      body: Container(
        child: pokemonsCapturados(),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        currentIndex: 0,
      ),
    );
  }

  Widget pokemonsCapturados() {
    PokemonRepository _pokemonRepository = PokemonRepository();

    return FutureBuilder<List<PokemonCapture>>(
      future: PokemonUserRepository().findAllCapturedPokemon(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          List<PokemonCapture> capturedPokemons = snapshot.data ?? [];
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
            ),
            itemCount: capturedPokemons.length,
            itemBuilder: (context, index) {
              return FutureBuilder<Pokemon?>(
                future: _pokemonRepository
                    .getPokemon(int.parse(capturedPokemons[index].id)),
                builder: (context, pokemonSnapshot) {
                  if (pokemonSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (pokemonSnapshot.hasError) {
                    return Text('Error: ${pokemonSnapshot.error}');
                  } else {
                    Pokemon? pokemon = pokemonSnapshot.data;
                    if (pokemon != null) {
                      return CardPokemonBagWidget(
                        currentIndex: index,
                        pokemon: pokemon,
                      );
                    } else {
                      return Text('No Pokemon found');
                    }
                  }
                },
              );
            },
          );
        }
      },
    );
  }
}
