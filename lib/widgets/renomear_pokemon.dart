import 'package:flutter/material.dart';

class renomear_pokemon extends StatefulWidget {
  final String currentName;
  final Function(String) onNameChanged;

  renomear_pokemon({
    required this.currentName,
    required this.onNameChanged,
  });

  @override
  _renomear_pokemonState createState() => _renomear_pokemonState();
}

class _renomear_pokemonState extends State<renomear_pokemon> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentName);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nome Atual: ${widget.currentName}',
          style: const TextStyle(
              fontSize: 16,
              fontFamily: 'PressStart2P',
              fontWeight: FontWeight.bold),
        ),
        TextField(
          controller: _nameController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            widget.onNameChanged(_nameController.text);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: const Text(
            'Alterar Nome',
            style: TextStyle(
              color: Colors.black,
              fontSize: 10,
              fontFamily: 'PressStart2P',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
