import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key,});

  Future<void> _showEditImg(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.enhance_photo_translate),
              SizedBox(width: 10),
              Text('Alterar imagem'),
            ],
          ),
          content: SizedBox(
            height: 270,
            child: Column(
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape
                        .circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                      ),
                    ],
                  ),
                  child: Image.asset(
                    'assets/images/user_icon.png',
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 40,
                  width: 200,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                        type: FileType.image,
                      );

                      if (result != null) {
                        // ignore: unused_local_variable
                        PlatformFile file = result.files.first;
                      }
                    },
                    icon: const Icon(Icons.enhance_photo_translate),
                    label: const Text('Selecionar arquivo'),
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xFF4C7CF6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop('s');
              },
            ),
            TextButton(
              child: const Text('Salvar'),
              onPressed: () {
                Navigator.of(context).pop('s');
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: const Color.fromARGB(255, 236, 236, 236),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Positioned(
              top: 0,
              child: Container(
                height: 320,
                width: MediaQuery.of(context).size.width,
                color: const Color(0xFF4C7CF6),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 17, left: 8),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back,
                            color: Colors.white, size: 40),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 25, top: 8),
                        child: Image.asset(
                          'assets/logotype/logo-down-white.png',
                          fit: BoxFit.cover,
                          height: 70,
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 80),
                            child: Stack(
                              children: [
                                Image.asset(
                                  'assets/images/user_icon.png',
                                  fit: BoxFit.cover,
                                  height: 150,
                                ),
                                Positioned(
                                  bottom: 5,
                                  right: 10,
                                  child: Material(
                                    elevation: 4,
                                    shape: const CircleBorder(),
                                    child: IconButton(
                                      onPressed: () {
                                        _showEditImg(context);
                                      },
                                      icon: const Icon(
                                        Icons.enhance_photo_translate,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 18.0),
                            child: Text(
                              'user'.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'PressStart2P',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              '#0000'.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'PressStart2P',
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Theme(
                data: Theme.of(context).copyWith(
                  elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        shadowColor: Colors.grey.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.centerLeft,
                        elevation: 15),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Conta',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Center(
                      child: SizedBox(
                        height: 50,
                        width: 400,
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const DataPopup();
                              },
                            );
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Informações Pessoais',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.person,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Center(
                      child: SizedBox(
                        height: 50,
                        width: 400,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Alterar Senha',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.lock,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Center(
                      child: SizedBox(
                        height: 40,
                        width: 200,
                        child: FilledButton(
                          onPressed: () {},
                          style: FilledButton.styleFrom(
                            backgroundColor: const Color(0xFF4C7CF6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                          ),
                          child: const Text(
                            'Logout',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'PressStart2P',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DataPopup extends StatelessWidget {
  const DataPopup({super.key});

  Future<void> _showEditDialog(BuildContext context, List controller) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController controller0 =
            TextEditingController(text: controller[0]);
        TextEditingController dadoAAlterar =
            TextEditingController(text: controller[1]);

        return AlertDialog(
          title: Row(
            children: [
              const Icon(Icons.edit),
              const SizedBox(width: 10),
              Text('Editar ${dadoAAlterar.text}'),
            ],
          ),
          content: TextField(
            controller: controller0,
            decoration: const InputDecoration(labelText: 'Novo dado'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(dadoAAlterar.text);
              },
            ),
            TextButton(
              child: const Text('Salvar'),
              onPressed: () {
                Navigator.of(context).pop(dadoAAlterar.text);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var nome = 'Pedo';
    var apelido = 'Peh';
    var email = 'pehcarrera@vamoqvamo.com';

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35),
      ),
      contentPadding: EdgeInsets.zero,
      content: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: 370,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    color: Color(0xFFF55555),
                  ),
                  height: 50,
                  child: const Text(
                    'Dados pessoais',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'PressStart2P',
                        color: Color.fromARGB(235, 255, 255, 255)),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 40,
                              width: 190,
                              child: TextField(
                                decoration: const InputDecoration(
                                  labelText: 'Nome:',
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 5),
                                ),
                                enabled: false,
                                controller: TextEditingController(text: nome),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF000000),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 13,
                            ),
                            InkWell(
                              onTap: () {
                                _showEditDialog(
                                  context,
                                  [nome, 'nome'],
                                );
                              },
                              child: const Icon(
                                Icons.edit,
                                size: 28,
                                color: Color(0xFF000000),
                              ),
                            ),
                          ]),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 40,
                              width: 190,
                              child: TextField(
                                decoration: const InputDecoration(
                                  labelText: 'Apelido:',
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 5),
                                ),
                                enabled: false,
                                controller:
                                    TextEditingController(text: apelido),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF000000),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 13,
                            ),
                            InkWell(
                              onTap: () {
                                _showEditDialog(
                                  context,
                                  [apelido, 'apelido'],
                                );
                              },
                              child: const Icon(
                                Icons.edit,
                                size: 28, // Tamanho aumentado
                                color: Color(0xFF000000), // Cor do ícone preto
                              ),
                            ),
                          ]),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 40,
                              width: 190,
                              child: TextField(
                                decoration: const InputDecoration(
                                  labelText: 'Email:',
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 5),
                                ),
                                enabled: false,
                                controller: TextEditingController(text: email),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF000000),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 13,
                            ),
                            InkWell(
                              onTap: () {
                                _showEditDialog(
                                  context,
                                  [email, 'email'],
                                );
                              },
                              child: const Icon(
                                Icons.edit,
                                size: 28, // Tamanho aumentado
                                color: Color(0xFF000000), // Cor do ícone preto
                              ),
                            ),
                          ]),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.white,
                elevation: 8,
                shape: const CircleBorder(
                  side: BorderSide(color: Color.fromARGB(128, 0, 0, 0)),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(
                  Icons.close,
                  size: 24,
                  color: Colors.black54,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
