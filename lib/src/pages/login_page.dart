import 'package:flutter/material.dart';

import 'package:teste_login/constants.dart';
import 'package:teste_login/src/pages/info_page.dart';
import 'package:teste_login/src/store/login_store.dart';

class LoginPage extends StatelessWidget {
  final LoginStore _loginStore = LoginStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(24, 61, 79, 25),
              Color.fromRGBO(37, 125, 118, 25),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Usuário",
                        style: TextStyle(color: Colors.white),
                      ),
                      TextField(
                        onChanged: _loginStore.setUsername,
                        controller: _loginStore.usernameController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Senha",
                        style: TextStyle(color: Colors.white),
                      ),
                      TextField(
                        onChanged: _loginStore.setPassword,
                        obscureText: true,
                        controller: _loginStore.passwordController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () => _loginStore.validateAndNavigate(context),
                      child: const Text(
                        'Entrar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                  InkWell(
                    onTap: () => _loginStore.call("https://www.google.com/", "https://www.google.com/"),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text("Política de Privacidade"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onLogin(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => InfoPage()));
  }
}
