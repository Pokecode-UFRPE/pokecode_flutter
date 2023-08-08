import 'package:flutter/material.dart';

import 'expanders_filters.dart';

class PopupFilter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(70.0),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width - 20,
        height: MediaQuery.of(context).size.height - 20,
        
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                color: const Color(0xFFAACAFB),
                height: 40,
                child: const Text(
                  'Filtros',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PressStart2P',
                  ),
                ),
              ),
              const SizedBox(height: 10), // Espaço entre o título e a lista
              const ExpanderFilters(),
            ],
          ),
        
      ),
    );
  }
}
