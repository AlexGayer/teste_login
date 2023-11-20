import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste_login/src/store/info_store.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final InfoStore store = InfoStore();

  @override
  void initState() {
    super.initState();
    store.loadInfoList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
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
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16),
                  SizedBox(
                      width: 800,
                      height: 500,
                      child: Observer(
                        builder: (context) => store.loading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : Card(
                                child: store.infoList.isNotEmpty
                                    ? ListView.builder(
                                        itemCount: store.infoList.length,
                                        itemBuilder: (context, index) {
                                          return Card(
                                            child: ListTile(
                                              title: Text(store.infoList[index]),
                                              trailing: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  IconButton(
                                                    icon: const Icon(Icons.edit),
                                                    onPressed: () {
                                                      _editInfo(index);
                                                    },
                                                  ),
                                                  IconButton(
                                                    icon: const Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                    ),
                                                    onPressed: () {
                                                      _deleteInfo(index);
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    : const Card(
                                        child: Center(
                                          child: Text("Nenhuma Informação digitada !"),
                                        ),
                                      ),
                              ),
                      )),
                  const SizedBox(height: 16),
                  TextFormField(
                    textAlign: TextAlign.center,
                    controller: store.infoController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Digite seu texto',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      alignLabelWithHint: true,
                    ),
                    onFieldSubmitted: (value) {
                      store.saveInfo(value);
                      setState(() {});
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                  InkWell(
                    onTap: () => store.call("https://www.google.com/", "https://www.google.com/"),
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

  Future<void> _deleteInfo(int index) async {
    bool confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Excluir Informação'),
          content: const Text('Deseja excluir esta informação?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      setState(() {
        store.infoList.removeAt(index);
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('infoList', store.infoList);
    }
  }

  Future<void> _editInfo(int index) async {
    String editedInfo = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar Informação'),
          content: TextFormField(
            controller: TextEditingController(text: store.infoList[index]),
            decoration: const InputDecoration(
              hintText: 'Digite sua informação',
            ),
            onFieldSubmitted: (value) {
              Navigator.pop(context, value);
              setState(() {});
            },
          ),
          // actions: [
          //   TextButton(
          //     onPressed: () {
          //       Navigator.pop(context);
          //     },
          //     child: const Text('Cancelar'),
          //   ),
          //   TextButton(
          //     onPressed: () {
          //       Navigator.pop(context, store.infoList[index]);
          //     },
          //     child: const Text('Salvar'),
          //   ),
          // ],
        );
      },
    );

    if (editedInfo != "") {
      setState(() {
        store.infoList[index] = editedInfo;
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('infoList', store.infoList);
    }
  }
}
