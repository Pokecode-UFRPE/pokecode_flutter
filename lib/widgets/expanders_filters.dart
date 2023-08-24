import 'package:flutter/material.dart';
import 'package:pokecode/widgets/pokemon_type_badge.dart';
import '../services/db_firestore.dart';

class ExpanderFilters extends StatefulWidget {
  const ExpanderFilters({Key? key}) : super(key: key);

  @override
  State<ExpanderFilters> createState() => _ExpanderFiltersState();
}

class _ExpanderFiltersState extends State<ExpanderFilters> {
  bool _tipoExpanded = true;
  bool _geracaoExpanded = false;
  bool _formatoExpanded = false;
  bool _corExpanded = false;
  bool _raridadeExpanded = false;

  List<String>? _tipoIndices;
  List<String>? _colorIndices;
  List<String>? _shapesIndices;
  List<String> raridades = ['baby', 'legendary', 'mythical'];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    List<String>? tipos = await getTypes();
    List<String>? cores = await getColors();
    List<String>? shapes = await getShapes();
    setState(() {
      _tipoIndices = tipos;
      _colorIndices = cores;
      _shapesIndices = shapes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, ['','']); 
        return true; 
      },
      child: Column(
        children: [
          _buildExpander('Tipo', _tipoExpanded, _buildTipoContent()),
          _buildExpander('Geração', _geracaoExpanded, _buildGeracaoContent()),
          _buildExpander('Formato', _formatoExpanded, _buildFormatoContent()),
          _buildExpander('Cor', _corExpanded, _buildCorContent()),
          _buildExpander('Raridade', _raridadeExpanded, _buildRaridadeContent()),          
          SizedBox(height: 80,)
        ],
      ),
    );
  }

  Widget _buildExpander(String header, bool isExpanded, Widget content) {
    return ExpansionPanelList(
      elevation: 4,
      expandedHeaderPadding: const EdgeInsets.all(0),
      animationDuration: const Duration(milliseconds: 300),
      children: [
        ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(
                header,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'PressStart2P',
                ),
              ),
            );
          },
          body: Container(
            padding: const EdgeInsets.all(16),
            child: content,
          ),
          isExpanded: isExpanded,
        ),
      ],
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          switch (header) {
            case 'Tipo':
              _tipoExpanded = !isExpanded;
              break;
            case 'Geração':
              _geracaoExpanded = !isExpanded;
              break;
            case 'Formato':
              _formatoExpanded = !isExpanded;
              break;
            case 'Cor':
              _corExpanded = !isExpanded;
              break;
            case 'Raridade':
              _raridadeExpanded = !isExpanded;
              break;
          }
        });
      },
    );
  }

  Widget _buildTipoContent() {
    if (_tipoIndices == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10),
      itemCount: _tipoIndices!.length,
      itemBuilder: (context, index) {
        final tipo = _tipoIndices![index];
        return InkWell(
          onTap: () {
            Navigator.pop(context, ['typing', tipo]);
          },
          child: Container(
            alignment: Alignment.center,
            child: PokemonTypeBadge(type: tipo),
          ),
        );
      },
    );
  }

  Widget _buildGeracaoContent() {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: 8,
      itemBuilder: (context, index) {
        final geracao = index + 1;
        return InkWell(
          onTap: () {
            Navigator.pop(context, ['gen_introduced', geracao.toString()]);
          },
          child: Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Color.fromARGB(218, 255, 85, 85), // Cor de fundo
              shape: BoxShape.circle, // Define a forma como círculo
            ),
            child: Text(
              '$geracaoª',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFormatoContent() {
    if (_shapesIndices == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 0.8,
        // mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: _shapesIndices!.length,
      itemBuilder: (context, index) {
        final shape = _shapesIndices![index];
        return InkWell(
          onTap: () {
            Navigator.pop(context, ['shape', shape]);
          },
          child: Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Image.asset('assets/images/shapes/$shape.webp'),
                  Text(
                    shape.toString(),
                    style: const TextStyle(
                      fontSize: 9.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Color.fromARGB(255, 80, 77, 77),
                    ),
                  )
                ],
              )),
        );
      },
    );
  }

  Widget _buildCorContent() {
    if (_colorIndices == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        childAspectRatio: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: _colorIndices!.length,
      itemBuilder: (context, index) {
        final cor = _colorIndices![index];
        return InkWell(
          onTap: () {
            Navigator.pop(context, ['primary_color', cor]);
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: getCorFromNome(cor),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black87)),
          ),
        );
      },
    );
  }

  Widget _buildRaridadeContent() {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemCount: 3,
      itemBuilder: (context, index) {
        final raridade = raridades[index];
        return InkWell(
          onTap: () {
            Navigator.pop(context, ['raridade', raridade.toString()]);
          },
          child: Center(
              child: Column(
            children: [
              getRaridadeIcon(raridade),
              const SizedBox(height: 10),
              Text(raridade)
            ],
          )),
        );
      },
    );
  }
}

Color getCorFromNome(String nomeCor) {
  Map<String, Color> cores = {
    "Green": Colors.green,
    "Red": Colors.red,
    "Blue": Colors.blue,
    "Yellow": Colors.yellow,
    "Black": Colors.black,
    "White": Colors.white,
    "Purple": Colors.purple,
    "Pink": Colors.pink,
    "Brown": Colors.brown,
    "Gray": Colors.grey,
  };
  return cores[nomeCor] ?? Colors.transparent;
}

Icon getRaridadeIcon(String nomeIcon) {
  Map<String, IconData> img = {
    "baby": Icons.cake,
    "legendary": Icons.auto_awesome_sharp,
    "mythical": Icons.diamond_rounded,
  };
  return Icon(img[nomeIcon] ?? Icons.help_outline);
}
