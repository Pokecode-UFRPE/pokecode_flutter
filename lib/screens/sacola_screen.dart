import 'package:flutter/material.dart';

import '../models/PokemonModel.dart';
import '../repository/PokemonRepository.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/bottom_navigation_bar_widget.dart';
import '../widgets/pokemon_type_badge.dart';

class SacolaScreen extends StatefulWidget {
  @override
  _SacolaScreenState createState() => _SacolaScreenState();
}

class _SacolaScreenState extends State<SacolaScreen> {
  List<PokemonModel> _pokemonList = [];
  final PokemonRepository pokemonRepository = PokemonRepository();

  @override
  void initState() {
    super.initState();
    pokemonRepository.findByCapturados().then((value) {
      setState(() {
        _pokemonList = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(currentIndex: 0),
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: _pokemonList == []
              ? const Center(
            child: Text('Nenhum Pokémon capturado.'),
          )
              : Column(
            children: [
              Expanded(child:
              ListView.builder(
                shrinkWrap: true,
                itemCount: _pokemonList.length,
                itemBuilder: (context, index) {
                  final pokemon = _pokemonList[index];
                  return Card(
                      color: Colors.white,
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '#${pokemon.id.padLeft(4, '0')}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade500,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              pokemon.name,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              foregroundColor:
                              const Color.fromARGB(255, 255, 191, 0),
                              radius:
                              MediaQuery
                                  .of(context)
                                  .size
                                  .width / 7,
                              child: ClipOval(
                                child: Image.network(
                                  pokemon.image,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Wrap(
                              spacing: 1.0,
                              children: List.generate(
                                pokemon.types.length,
                                    (typeIndex) {
                                  final type = pokemon.types[typeIndex];
                                  return PokemonTypeBadge(
                                    type: type,
                                    small: true,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ));
                },
              ))

            ],
          )),
      bottomNavigationBar: BottomNavigationBarWidget(
        currentIndex: 0,
      ),
    );
  }
}
