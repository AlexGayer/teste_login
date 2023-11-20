// lib/stores/login_store.dart
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:teste_login/constants.dart';
import 'package:teste_login/src/pages/info_page.dart';
import 'package:url_launcher/url_launcher.dart';
part 'login_store.g.dart';

@injectable
class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  @observable
  String username = '';

  @observable
  String password = '';

  @action
  void setUsername(String value) => username = value.trim();

  @action
  void setPassword(String value) => password = value.trim();

  @computed
  bool get isFormValid => username.isNotEmpty && password.length >= 2 && !username.endsWith(' ') && !password.endsWith(' ');

  void validateAndNavigate(BuildContext context) {
    String username = usernameController.text.trim();
    String password = passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      _showAlertDialog('Erro', 'Por favor, preencha todos os campos.');
      return;
    }

    if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(password) || username.endsWith(' ') || password.endsWith(' ')) {
      _showAlertDialog(
        'Erro',
        'Não é permitido utilizar caracteres especiais no campo Senha..',
      );
      return;
    }

    if (password.length < 2 || !RegExp(r'^[a-zA-Z0-9]+$').hasMatch(password) || username.length > 20 || password.length > 20 || username.endsWith(' ') || password.endsWith(' ')) {
      _showAlertDialog(
        'Erro',
        'Os campos Usuário ou Senha não podem ultrapassar 20 caracteres..',
      );
      return;
    }

    // Se todas as verificações passarem, navegue para a próxima tela.
    _navigateToNextScreen();
  }

  void _showAlertDialog(String title, String message) {
    showDialog(
      context: ctx,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToNextScreen() {
    Navigator.push(
        ctx,
        MaterialPageRoute(
          builder: (context) => InfoPage(),
        ));
  }

  call(String url, String fallbackUrl) async {
    final Uri _url = Uri.parse(url);
    final Uri _fallbackUrl = Uri.parse(fallbackUrl);
    try {
      bool launched = await launchUrl(_url);
      if (!launched) {
        await launchUrl(_fallbackUrl);
      }
    } catch (_) {
      await launchUrl(_fallbackUrl);
    }
  }
}
