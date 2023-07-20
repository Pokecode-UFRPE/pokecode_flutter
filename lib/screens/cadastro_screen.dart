import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({Key? key}) : super(key: key);

  @override
  State<CadastroScreen> createState() => _CadastroScreen();
}

class _CadastroScreen extends State<CadastroScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                    TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "Por favor informe seu email";
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
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      child: TextFormField(
                        controller: _userController,
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return "Por favor informe seu usuário";
                          }
                          return null;
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
                            labelText: 'Usuário',
                            labelStyle: const TextStyle(
                                color: CupertinoColors.tertiaryLabel,
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: _passwordController,
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "Por favor informe sua senha";
                        }
                        return null;
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
                          labelText: 'Senha',
                          labelStyle: const TextStyle(
                              color: CupertinoColors.tertiaryLabel,
                              fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          shadowColor: Colors.blueGrey),
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          Navigator.pushReplacementNamed(context, '/');
                        }
                      },
                      child: const Text('CADASTRO',
                          style: TextStyle(fontSize: 20, fontFamily: 'PS2')),
                    ),
                  ),
                ),
                Container(
                    height: MediaQuery.of(context).size.height * .2,
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Já possui uma conta?',
                        ),
                        TextButton(
                            onPressed: () => Navigator.pushReplacementNamed(
                                context, '/login'),
                            child: const Text(
                              "Clique aqui",
                              style: TextStyle(color: Colors.deepOrange),
                            ))
                      ],
                    ))
              ],
            )),
      ),
    );
  }
}
