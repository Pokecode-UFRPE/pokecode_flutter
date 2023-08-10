import 'package:flutter/material.dart';
import '../services/db_firestore.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/bottom_navigation_bar_widget.dart';
import '../widgets/card_pokemon_horizontal.dart';

class PokedexScreen extends StatefulWidget {
  @override
  _PokedexScreenState createState() => _PokedexScreenState();
}

class _PokedexScreenState extends State<PokedexScreen> {
  String _valorInput = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        currentIndex: 0,
        valorInput: _valorInput,
        onInputChanged: (newValue) {
          setState(() {
            _valorInput = newValue;
          });
        },
      ),
      body: selecaoWidget(_valorInput),
      bottomNavigationBar: BottomNavigationBarWidget(
        currentIndex: 1,
      ),
    );
  }

  Widget selecaoWidget(String inputValue) {
    if (inputValue.isEmpty) {
      return pokeComum();
    } else {
      return pokeInput(inputValue);
    }
  }

  Widget pokeComum() {
    return ListView.builder(
      itemCount: 899,
      itemBuilder: (context, index) {
        return FutureBuilder<Pokemon?>(
          future: getPokemon(index + 1),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
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
                  margin: const EdgeInsets.symmetric(vertical: 20),
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

  Widget pokeInput(String name) {
    return FutureBuilder<List<Pokemon>>(
      future: getPokemonsInput(name),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
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
            return Text('No results found.');
          }
        }
      },
    );
  }
}
