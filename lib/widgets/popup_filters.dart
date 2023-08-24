import 'package:flutter/material.dart';

import 'expanders_filters.dart';

class PopupFilter extends StatelessWidget {
  const PopupFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: double.maxFinite,
            height: double.maxFinite,

            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5)),
                      color: Color(0xFFAACAFB),
                    ),
                    height: 50,
                    child: const Text(
                      'Filtros',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'PressStart2P',
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ExpanderFilters(),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context, ['', '']);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.white,
                elevation: 8,
                shape: const CircleBorder(
                  side: BorderSide(
                      color: Color.fromARGB(128, 0, 0, 0)), // Borda preta clarinha
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(10.0), // Espaçamento interno do ícone
                child: Icon(
                  Icons.close, // Ícone "X"
                  size: 24, // Tamanho do ícone
                  color: Colors.black54, // Cor do ícone preto clarinho
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
