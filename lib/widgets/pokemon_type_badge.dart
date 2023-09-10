import 'package:flutter/material.dart';

class PokemonTypeBadge extends StatelessWidget {
  final String type;

  const PokemonTypeBadge({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formattedType =
        type.replaceAll('[', '').replaceAll(']', '').toUpperCase();

    Color backgroundColor = _getColorForType(formattedType);

    return Container(
      margin: const EdgeInsetsDirectional.only(end: 5),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
      width: 75,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        formattedType,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color _getColorForType(String type) {
    final Map<String, Color> typeColors = {
      'NORMAL': Color.fromARGB(255, 144, 153, 162)!,
      'FIGHTING': Color.fromARGB(255, 206, 63, 107)!,
      'FLYING': Color.fromARGB(255, 143, 168, 222)!,
      'POISON': Color.fromARGB(255, 171, 106, 200)!,
      'GROUND': Color.fromARGB(255, 214, 119, 70)!,
      'ROCK': Color.fromARGB(255, 201, 182, 139)!,
      'BUG': Color.fromARGB(255, 145, 192, 45)!,
      'GHOST': Color.fromARGB(255, 82, 105, 173)!,
      'STEEL': Color.fromARGB(255, 91, 142, 161)!,
      'FIRE': Color.fromARGB(255, 254, 156, 85)!,
      'WATER': Color.fromARGB(255, 77, 144, 214)!,
      'GRASS': Color.fromARGB(255, 101, 188, 94)!,
      'ELECTRIC': Color.fromARGB(255, 244, 210, 59)!,
      'PSYCHIC': Color.fromARGB(255, 249, 112, 119)!,
      'ICE': Color.fromARGB(255, 155, 206, 191)!,
      'DRAGON': Color.fromARGB(255, 9, 109, 195)!,
      'DARK': Color.fromARGB(255, 91, 82, 101)!,
      'FAIRY': Color.fromARGB(255, 236, 144, 231)!,
    };

    return typeColors[type.toUpperCase()] ?? Colors.deepOrange;
  }

  Color _getTextColorForBackground(Color backgroundColor) {
    final double threshold = 128;
    final double bgLuminance = (0.2126 * backgroundColor.red +
        0.7152 * backgroundColor.green +
        0.0722 * backgroundColor.blue);

    return bgLuminance < threshold ? Colors.white : Colors.black;
  }
}
