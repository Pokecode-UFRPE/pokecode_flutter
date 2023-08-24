import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key});

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
                            child: Image.asset(
                              'assets/images/user_icon.png',
                              fit: BoxFit.cover,
                              height: 150,
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
                        shadowColor:
                            Colors.grey.withOpacity(0.5), // Cor da sombra
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
                                return DataPopup();
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
                            backgroundColor: const Color(
                                0xFF4C7CF6), // Cor de fundo do botão
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(8), // Raio do botão
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12), // Espaçamento interno do botão
                          ),
                          child: const Text(
                            'Logout',
                            style: TextStyle(
                              color: Colors.white, // Cor do texto
                              fontFamily: 'PressStart2P', // Fonte PressStart2P
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
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(35), // Define o valor do arredondamento
      ),
      contentPadding: EdgeInsets.zero,
      content: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 2.5 / 3,
            height: 460,
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
                        fontSize: 18,
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
                      const Text(
                        'Nome:',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF000000), // Cor do texto preto
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 40,
                              width: 300,
                              child: TextField(
                                enabled: false,

                                // controller: TextEditingController(text: 'Valor da Variável'),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF000000),
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 243, 239, 239),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(2)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFFD3D3D3)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(2)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 219, 212, 212)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(2)),
                                  ),
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 8),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 13,
                            ),
                            InkWell(
                              onTap: () {
                                // Função a ser executada ao clicar no ícone
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
                      const Text(
                        'Apelido:',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF000000), // Cor do texto preto
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 40,
                              width: 300,
                              child: TextField(
                                enabled: false,
                                // controller: TextEditingController(text: 'Valor da Variável'),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF000000),
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 243, 239, 239),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(2)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFFD3D3D3)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(2)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 219, 212, 212)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(2)),
                                  ),
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 8),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 13,
                            ),
                            InkWell(
                              onTap: () {
                                // Função a ser executada ao clicar no ícone
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
                      const Text(
                        'Email:',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF000000), // Cor do texto preto
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 40,
                              width: 300,
                              child: TextField(
                                enabled: false,

                                // controller: TextEditingController(text: 'Valor da Variável'),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF000000),
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 243, 239, 239),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(2)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFFD3D3D3)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(2)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 219, 212, 212)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(2)),
                                  ),
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 8),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 13,
                            ),
                            InkWell(
                              onTap: () {
                                // Função a ser executada ao clicar no ícone
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
