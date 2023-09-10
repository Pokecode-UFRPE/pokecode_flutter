import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokecode/models/PokemonCapture.dart';
import 'package:pokecode/repository/PokemonUserRepository.dart';
import 'package:pokecode/screens/pokemon/recommendation/widgets/card_simples_recomendacao_widget.dart';

import '../../../../models/Pokemon.dart';
import '../../../../repository/PokemonRepository.dart';

class RowRecommendationWidget extends StatefulWidget {
  const RowRecommendationWidget({super.key});

  @override
  State<StatefulWidget> createState() => _RowRecommendationWidgetState();
}

class _RowRecommendationWidgetState extends State<RowRecommendationWidget> {
  final PokemonUserRepository _pokemonUserRepository = PokemonUserRepository();
  String elementPhrase = "Talvez você goste desses...";

  Future<int> getPokemonIndex() async {
    List<PokemonCapture> list = await _pokemonUserRepository.findAllPokemon();
    if (list.isEmpty) {
      return 1 + Random().nextInt(777 - 1 + 1);
    }
    PokemonCapture? pokemon = await _pokemonUserRepository
        .findById(list[Random().nextInt(list.length - 1 + 1)].id);
    return int.parse(pokemon!.id);
  }

  Future<List<int>> getSimilars() async {
    final int index = await getPokemonIndex();
    final url = Uri.parse('http://192.168.15.5:3001/$index?quantity=30');
    final httpResponse = await http.get(url);
    var body = json.decode(httpResponse.body).cast<int>();
    print("${body[0]} é parecido com os outros ${body}");
    return body;
  }

  Future<String> choiceTitle(String pokedexId) async {
    final PokemonCapture? pokemonCapture =
        await _pokemonUserRepository.findById(pokedexId);
    final List<String> isNotExists = [
      "Talvez você goste desses",
      "Esses parecem interessantes",
      "Dê uma olhada nestes Pokémon!",
      "Está na hora de conhecer essas criaturas",
      "Pode ser que esses Pokémon chamem a sua atenção",
      "Que tal dar uma olhada nessa seleção?",
      "Explorando novas opções Pokémon",
      "Novos amigos Pokémon para você considerar",
      "Descubra o mundo dos Pokémon com essas sugestões",
      "Quem sabe um desses não se torna o seu favorito?"
    ];

    final random = Random();
    if (pokemonCapture == null) {
      return isNotExists[random.nextInt(isNotExists.length)];
    }
    Pokemon? pokemon =
        await PokemonRepository().getPokemon(int.parse(pokemonCapture.id) + 1);
    String pokemonName = pokemon!.name;

    final List<String> isLiked = [
      "Acho que já vimos algo parecido por aqui",
      "Pode ser que essas sugestões se encaixem bem",
      "Veja se algo dessa lista chama a sua atenção",
      "Estes parecem estar no mesmo universo que seus gostos",
      "Talvez você curta esses Pokémon também",
      "Essas escolhas têm um certo charme, não acha?",
      "Estes Pokémon podem se encaixar bem com o que você gosta.",
      "Descubra esses Pokémon que têm algo em comum com o que você curte.",
      "Conheça novas possibilidades que têm a ver com suas preferências.",
      "Dê uma olhada nessas escolhas, elas podem te surpreender.",
      "Temos algumas opções que podem estar na sua mesma vibe.",
      "Amplie suas opções com esses Pokémon que têm um toque especial.",
    ];
    final List<String> isLikeWithName = [
      "Acho que esses vão te trazer lembranças de ${pokemonName}, afinal você curtiu!",
      "Porque você curtiu ${pokemonName}, acredito que esses vão ser do seu gosto também.",
      "Pegamos uns Pokémon que têm um toque parecido com ${pokemonName}, sabia?",
      "Olha só, ${pokemonName} tem uns colegas de estilo por aqui, que tal?",
      "Eles são tipo uns primos distantes de ${pokemonName}, você vai ver!",
      "Quer dar uma olhada? Esses têm um quê de ${pokemonName}, que você gostou.",
      "Juntamos uns Pokémon que têm uma vibe similar a ${pokemonName}, aproveite!",
      "Lembra de ${pokemonName}? Esses são quase como a continuação da história.",
      "Se curte ${pokemonName}, acho que vai curtir a companhia desses Pokémon!",
      "Esses Pokémon têm um ar meio ${pokemonName}, vai por mim.",
      "Ei, ${pokemonName} tem uns parceiros de aventura chegando, não é demais?",
      "Dá uma olhada nesses! Têm umas semelhanças legais com ${pokemonName}.",
      "Acredita que encontramos uns Pokémon que combinam com o estilo de ${pokemonName}?",
      "Trazendo uns Pokémon que lembram um pouco ${pokemonName}, o que acha?",
      "Parece que ${pokemonName} inspirou uns amiguinhos Pokémon por aqui, hein."
    ];
    var together = isLiked + isLikeWithName;
    return together[random.nextInt(together.length)];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder<List<int>>(
        future: getSimilars(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 20.0),
              child: Image.asset('assets/images/spinner_ball.gif', height: 40),
            );
          } else if (snapshot.hasError) {
            return const Text('Erro ao carregar os dados de recomendação.');
          } else {
            final similarIndices = snapshot.data!;
            final pokedexReferenceId = similarIndices[0].toString();
            similarIndices.remove(similarIndices.first);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5, bottom: 10, top: 20),
                  child: FutureBuilder<String>(
                    future: choiceTitle(pokedexReferenceId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Erro: ${snapshot.error}');
                      } else {
                        final title = snapshot.data!;
                        return Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        );
                      }
                    },
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: similarIndices.map((index) {
                      return FutureBuilder<Pokemon?>(
                        future: PokemonRepository().getPokemon(index),
                        builder: (BuildContext context,
                            AsyncSnapshot<Pokemon?> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            final pokemon = snapshot.data!;
                            return CardSimplesRecomendacaoWidget(
                              currentIndex: index,
                              pokemon: pokemon,
                            );
                          }
                        },
                      );
                    }).toList(),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
