import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EsqueciSenhaScreen extends StatefulWidget {
  const EsqueciSenhaScreen({Key? key}) : super(key: key);

  @override
  State<EsqueciSenhaScreen> createState() => _EsqueciSenhaScreen();
}

class _EsqueciSenhaScreen extends State<EsqueciSenhaScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 25),
            color: CupertinoColors.extraLightBackgroundGray,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: const AssetImage('assets/logotype/logo-down.png'),
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      margin: const EdgeInsets.only(bottom: 30),
                      child: const Text(
                        "Informe seu email para receber o link de recuperação de senha:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "Por favor informe um email válido";
                        }
                        if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value!)) {
                          return "Email inválido";
                        }
                      },
                      decoration: InputDecoration(
                          fillColor: const Color.fromRGBO(224, 224, 224, 1.0),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          contentPadding: const EdgeInsets.only(
                              top: 18, bottom: 18, left: 20, right: 20),
                          labelText: 'Email',
                          labelStyle: const TextStyle(
                              color: CupertinoColors.tertiaryLabel,
                              fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              shadowColor: Colors.blueGrey),
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Você receberá as próximas instruções no seu email!')),
                              );
                              Navigator.pushReplacementNamed(context, '/login');
                            }
                          },
                          child: const Text('ENVIAR',
                              style:
                                  TextStyle(fontSize: 20, fontFamily: 'PS2')),
                        ),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            side: const BorderSide(color: Colors.transparent),
                          ),
                          onPressed: () =>
                              Navigator.pushReplacementNamed(context, '/login'),
                          child: const Text('Cancelar',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'PS2',
                                  fontWeight: FontWeight.normal)),
                        ),
                      ]),
                ),
              ],
            )),
      ),
    );
  }
}
