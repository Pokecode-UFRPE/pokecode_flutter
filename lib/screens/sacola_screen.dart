import 'package:flutter/material.dart';
import '../services/db_firestore.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/bottom_navigation_bar_widget.dart';
import '../widgets/card_pokemon_bag_widget.dart';

class SacolaScreen extends StatefulWidget {
  @override
  _SacolaScreenState createState() => _SacolaScreenState();
}

class _SacolaScreenState extends State<SacolaScreen> {
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
      body: Container(
        child: pokemonsCapturados(),
        
      ),
      bottomNavigationBar: BottomNavigationBarWidget(currentIndex: 0,),
    );
  }

  Widget pokemonsCapturados() {
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 0.8,
      // crossAxisSpacing: 1,
      // mainAxisSpacing: 1,
      // mainAxisExtent: 270
    ),
    itemCount: 899,
    itemBuilder: (context, index) {
      return FutureBuilder<Pokemon?>(
        future: getPokemon(index + 1),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: Image.asset('assets/images/spinner_ball.gif', height: 40),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            Pokemon? pk = snapshot.data;
            if (pk != null) {
              return CardPokemonBagWidget(currentIndex: 0, pokemon: pk);
            } else {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: Image.asset('assets/images/spinner_ball.gif', height: 40),
              );
            }
          }
        },
      );
    },
  );
}

}
