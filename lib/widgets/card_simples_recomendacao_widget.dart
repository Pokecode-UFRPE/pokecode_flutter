import 'package:flutter/material.dart';
import 'package:pokecode/services/db_firestore.dart';
import 'package:pokecode/widgets/popup_pokemon_selected.dart';

// ignore: must_be_immutable
class CardSimplesRecomendacaoWidget extends StatelessWidget {
  final int currentIndex;
  Pokemon? pokemon;

  CardSimplesRecomendacaoWidget(
      {super.key, required this.currentIndex, required this.pokemon});

  @override
  // corrigindo o valor do nº da pokedex para chamar a imagem corretamente
  Widget build(BuildContext context) {
    String link = '';
    if (pokemon!.pokedex_number < 10){
      link = 'https://raw.githubusercontent.com/HybridShivam/Pokemon/master/assets/images/00${pokemon!.pokedex_number}.png';
    } else if ((pokemon!.pokedex_number < 100)){
      link = 'https://raw.githubusercontent.com/HybridShivam/Pokemon/master/assets/images/0${pokemon!.pokedex_number}.png';
    } else {
      link = 'https://raw.githubusercontent.com/HybridShivam/Pokemon/master/assets/images/${pokemon!.pokedex_number}.png';
    }
    List<String> tipos = pokemon!.typing.split("~");
    
    return SizedBox(
      width: MediaQuery.of(context).size.width / 3,
      height: MediaQuery.of(context).size.height / 3,
      child: Card(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/bg_recomendacoes/${tipos[0]}.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Image.network(
                link,
                fit: BoxFit.contain,
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Color.fromARGB(255, 255, 255, 255),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return PopupPokemonSelected(
                        name: pokemon!.name,
                        number_pokedex: pokemon!.pokedex_number,
                        types: tipos,
                        capturado: true,
                        link: link
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
