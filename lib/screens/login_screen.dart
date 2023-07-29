import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() async {
    final String username = _loginController.text.trim();
    final String password = _passwordController.text.trim();
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: username,
        password: password,
      );

      Navigator.pushReplacementNamed(context, '/');
    } catch (e) {
      // Lidar com erros de login
      print('Erro durante o login: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuário ou senha incorretos!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: _formKey,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(right: 25, left: 25),
            color: CupertinoColors.extraLightBackgroundGray,
            child: SingleChildScrollView(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Image(
                    image: const AssetImage('assets/logotype/logo-up.png'),
                    height: MediaQuery.of(context).size.height * 0.4,
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 25),
                          child: TextFormField(
                            controller: _loginController,
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return "Por favor informe seu usuário";
                              }
                              if (!RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value!)) {
                                return "Email inválido";
                              }
                            },
                            decoration: InputDecoration(
                                fillColor:
                                    const Color.fromRGBO(224, 224, 224, 1.0),
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
                          },
                          decoration: InputDecoration(
                              fillColor:
                                  const Color.fromRGBO(224, 224, 224, 1.0),
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
                    )),
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    child: const Text(
                      'Esqueci a senha',
                      style: TextStyle(color: CupertinoColors.systemGrey2),
                    ),
                    onPressed: () => Navigator.pushReplacementNamed(
                        context, '/esqueci-senha'),
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _login();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        shadowColor: Colors.blueGrey),
                    child: const Text('LOGIN',
                        style: TextStyle(fontSize: 20, fontFamily: 'PS2')),
                  ),
                ),
                Container(
                    height: MediaQuery.of(context).size.height * .2,
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Não possui uma conta?',
                        ),
                        TextButton(
                            onPressed: () => Navigator.pushReplacementNamed(
                                context, '/cadastro'),
                            child: const Text(
                              "Clique aqui",
                              style: TextStyle(color: Colors.deepOrange),
                            ))
                      ],
                    ))
              ],
            )),
          )),
    );
  }
}
