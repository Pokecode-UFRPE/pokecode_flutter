import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pokecode/repository/EquipeRepository.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../models/equipe.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/bottom_navigation_bar_widget.dart';

class ListaEquipes extends StatefulWidget {
  @override
  _ListaEquipesState createState() => _ListaEquipesState();
}

class _ListaEquipesState extends State<ListaEquipes> {
  String _inputValue = "";
  List _filterAndValue = ['', ''];
  bool _isFormEquipeVisible = false;
  Equipe? _selectedEquipe; // Armazena a equipe selecionada
  final EquipeRepository equipeRepository = EquipeRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        currentIndex: 0,
        valorInput: _inputValue,
        filtroEValorAppBar: _filterAndValue,
        onInputChanged: (newValue) {
          setState(() {
            _inputValue = newValue;
          });
        },
        onPopupChanged: (newValue) {
          setState(() {
            _filterAndValue = newValue;
          });
        },
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Text(
                      'Equipes de Batalha',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                      icon: Icon(Icons.add),
                      label: Text('Nova Equipe'),
                      onPressed: () {
                        setState(() {
                          _isFormEquipeVisible = true;
                        });
                      },
                    ),
                  ),
                ],
              ),
              FutureBuilder<List<Equipe>>(
                future: equipeRepository.findAllEquipes(), // Chama a função que retorna o Future
                builder: (BuildContext context, AsyncSnapshot<List<Equipe>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Erro ao carregar equipes: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('Nenhuma equipe encontrada.');
                  } else {
                    List<Equipe>? equipes = snapshot.data;
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: ListView.builder(
                          itemCount: equipes?.length,
                          itemBuilder: (ctx, i) => EquipeWidget(equipes![i], _editEquipe),
                        ),
                      ),
                    );
                  }
                },
              )
            ],
          ),
          if (_isFormEquipeVisible)
            Container(
              color: Colors.black.withOpacity(0.5),
            ),
          if (_isFormEquipeVisible)
            Center(
              child: FormEquipe(
                equipe: _selectedEquipe,
                onClose: () {
                  setState(() {
                    _isFormEquipeVisible = false;
                    _selectedEquipe = null; // Limpa a equipe selecionada
                  });
                },
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        currentIndex: 0,
      ),
    );
  }

  // Função para abrir o formulário de edição com os argumentos da equipe selecionada
  void _editEquipe(Equipe equipe) {
    setState(() {
      _isFormEquipeVisible = true;
      _selectedEquipe = equipe; // Armazena a equipe selecionada
    });
  }
}

class FormEquipe extends StatefulWidget {
  final Equipe? equipe;
  final VoidCallback onClose;

  FormEquipe({required this.equipe, required this.onClose});

  @override
  _FormEquipeState createState() => _FormEquipeState();
}

class _FormEquipeState extends State<FormEquipe> {
  final _form = GlobalKey<FormState>();
  final Map<String, String?> _formData = {};
  final EquipeRepository equipeRepository = EquipeRepository();
  @override
  void initState() {
    super.initState();
    if (widget.equipe != null) {
      _loadFormData();
    }
  }

  void _loadFormData() {
    final equipe = widget.equipe!;
    _formData['id'] = equipe.id;
    _formData['name'] = equipe.name;
    _formData['pokemon1'] = equipe.pokemon1;
    _formData['pokemon2'] = equipe.pokemon2;
    _formData['pokemon3'] = equipe.pokemon3;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      content: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Ajustar equipe',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        ElevatedButton.icon(
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                            foregroundColor:
                            MaterialStateProperty.all(Colors.blueAccent)
                          ),
                          icon: Icon(Icons.cancel),
                          label: Text('Cancelar'),
                          onPressed: () async {
                              widget.onClose();
                          },
                        ),
                        SizedBox(width: 20.0),
                        ElevatedButton.icon(
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                            foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                          ),
                          icon: Icon(Icons.save),
                          label: Text('Salvar'),
                          onPressed: () async {
                            if (_form.currentState!.validate()) {
                              _form.currentState!.save();
                              Equipe equipe = Equipe(
                                  _formData['id'] ?? Uuid().v4().toString(),
                                _formData['name'] ?? '',
                                _formData['pokemon1'] ?? '',
                                _formData['pokemon2'] ?? '',
                                _formData['pokemon3'] ?? '',
                              );
                              equipeRepository.saveEquipe(equipe);
                              widget.onClose();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Form(
                key: _form,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: _formData['name'],
                      decoration: InputDecoration(labelText: 'Nome da Equipe'),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Nome da equipe é obrigatório';
                        }
                      },
                      onSaved: (value) => _formData['name'] = value,
                    ),
                    TextFormField(
                      initialValue: _formData['pokemon1'],
                      decoration: InputDecoration(labelText: 'Pokemon 1'),
                      onSaved: (value) => _formData['pokemon1'] = value,
                    ),
                    TextFormField(
                      initialValue: _formData['pokemon2'],
                      decoration: InputDecoration(labelText: 'Pokemon 2'),
                      onSaved: (value) => _formData['pokemon2'] = value,
                    ),
                    TextFormField(
                      initialValue: _formData['pokemon3'],
                      decoration: InputDecoration(labelText: 'Pokemon 3'),
                      onSaved: (value) => _formData['pokemon3'] = value,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class EquipeWidget extends StatelessWidget {
  final Equipe equipe;
  final Function(Equipe) onEdit;
  EquipeRepository equipeRepository = EquipeRepository();

  EquipeWidget(this.equipe, this.onEdit);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        equipe.name,
        style: TextStyle(
          fontSize: 13.0,
          fontFamily: 'PressStart2P',
        ),
      ),
      subtitle: Text(equipe.pokemon1 + ", " + equipe.pokemon2 + ", " + equipe.pokemon3),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                onEdit(equipe); // Chame a função de edição
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Colors.red,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text('Excluir Equipe'),
                    content: Text('Você tem certeza?'),
                    actions: <Widget> [
                      TextButton(
                        child: Text('Não'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('Sim'),
                        onPressed: () async {
                          equipeRepository.deleteById(equipe.id);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}