import 'package:flutter/material.dart';

import '../../models/Pokemon.dart';
import '../../models/PokemonCapture.dart';
import '../../repository/PokecenterRepository.dart';
import '../../repository/PokemonRepository.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/bottom_navigation_bar_widget.dart';
import '../../widgets/card_pokemon_pokecenter_widget.dart';

class PokecenterScreen extends StatefulWidget {
  @override
  _PokecenterScreenState createState() => _PokecenterScreenState();
}

class _PokecenterScreenState extends State<PokecenterScreen> {
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
    PokecenterRepository _pokecenterRepository = PokecenterRepository();
    PokemonRepository _pokemonRepository = PokemonRepository();

    return FutureBuilder<List<PokemonCapture>>(
      future: _pokecenterRepository.findAll(),
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
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: GridView.builder(
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
                        return CardPokemonPokecenterWidget(
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
            ),
          );
        }
      },
    );
  }
}
