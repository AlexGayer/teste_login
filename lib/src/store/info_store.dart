// lib/stores/info_store.dart
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste_login/constants.dart';
import 'package:url_launcher/url_launcher.dart';
part 'info_store.g.dart';

@injectable
class InfoStore = _InfoStore with _$InfoStore;

abstract class _InfoStore with Store {
  final infoController = TextEditingController();

  @observable
  bool _loading = false;

  @computed
  bool get loading => _loading;

  @observable
  ObservableList<String> infoList = ObservableList<String>();

  Future<void> saveInfoList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('infoList', infoList.toList());
  }

  Future<void> saveInfo(String info) async {
    if (info.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      infoList.add(info);
      await prefs.setStringList('infoList', infoList);
      infoController.clear();
      // Atualiza a tela para exibir as novas informações
    }
  }

  Future<void> loadInfoList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    infoList = ObservableList<String>.of(prefs.getStringList('infoList') ?? []);
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
