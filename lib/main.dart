import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async => runApp(
      MaterialApp(
        home: Home(),
        theme: ThemeData(hintColor: Colors.green, primaryColor: Colors.white),
      ),
    );

Future<Map> getData() async {
  String request = "https://api.hgbrasil.com/finance?format=json&key=629f2acc";
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();

  double dolar;
  double euro;

  void _clearAll() {
    realController.text = "";
    dolarController.text = "";
    euroController.text = "";
  } //funcao para apagar tudo que estiver nos campos de textos

  void _realChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
    } //caso tenha algo no campo de texto apague tudo

    double real = double.parse(text);
    dolarController.text = (real / dolar).toStringAsFixed(2);
    euroController.text = (real / euro).toStringAsFixed(2);

    void _dolarChanged(String text) {
      if (text.isEmpty) {
        _clearAll();
      }

      double dolar = double.parse(text);
      realController.text = (dolar * this.dolar).toStringAsFixed(2);
      euroController.text = (dolar * this.dolar / euro).toStringAsFixed(2);
    }

    void _euroChanged(String text) {
      if (text.isEmpty) {
        _clearAll();
      }

      double euro = double.parse(text); // faz a conversao de string para double
      realController.text = (euro * this.euro).toStringAsFixed(2);
      dolarController.text = (euro * this.euro / dolar).toStringAsFixed(2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Conversor de moeda"),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
          future: getData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: Text(
                    "Aguarde...",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 30.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              //   break;
              default:
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Ops, falha ao encontrar o dado",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 25.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                  euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                }
            }
          }),
    );
  }
}
