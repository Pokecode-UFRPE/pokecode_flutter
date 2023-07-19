import 'package:flutter/material.dart';

class CardPokemonHorizontalWidget extends StatelessWidget {
  final int currentIndex;

  CardPokemonHorizontalWidget({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.white,
        elevation: 4.0,
        shadowColor: Colors.black,
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 1.05,
          height: MediaQuery.of(context).size.width / 4,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '#0001',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Bulbasaur',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Card(
                            color: Color.fromRGBO(101, 188, 94, 1),
                            child: Container(
                              width: 56,
                              height: 18,
                              alignment: Alignment.center,
                              child: Text(
                                'grama',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Card(
                            color: Color.fromRGBO(171, 106, 200, 1),
                            child: Container(
                              width: 56,
                              height: 18,
                              alignment: Alignment.center,
                              child: Text(
                                'veneno',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.white, 
                  radius: MediaQuery.of(context).size.width / 8,
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/exemplo.png',
                      width: MediaQuery.of(context).size.width / 8,
                      height: MediaQuery.of(context).size.width / 8,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
