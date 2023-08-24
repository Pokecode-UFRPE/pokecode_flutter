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
      width: 80,
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
      'NORMAL': Colors.brown[400]!,
      'FIGHTING': Colors.red[800]!,
      'FLYING': Colors.blue[300]!,
      'POISON': Colors.purple[800]!,
      'GROUND': Colors.orange[700]!,
      'ROCK': Colors.grey[800]!,
      'BUG': Colors.lightGreen[700]!,
      'GHOST': Colors.deepPurple[800]!,
      'STEEL': Colors.blueGrey[400]!,
      'FIRE': Colors.red[600]!,
      'WATER': Colors.blue[600]!,
      'GRASS': Colors.green[600]!,
      'ELECTRIC': Colors.yellow[700]!,
      'PSYCHIC': Colors.pink[400]!,
      'ICE': Colors.cyan[300]!,
      'DRAGON': Colors.indigo[700]!,
      'DARK': Colors.brown[900]!,
      'FAIRY': Colors.pink[100]!,
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
