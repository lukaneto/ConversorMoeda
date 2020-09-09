import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(hintColor: Colors.white, primaryColor: Colors.white),
  ));
}

Future<Map> getData() async {
  String request = "https://api.hgbrasil.com/finance?format=json&key=629f2acc";

  http.Response response = await http.get(request);
  print(json.decode(response.body));

  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();
  final libraController = TextEditingController();
  final bitcoinController = TextEditingController();
  final pesoController = TextEditingController();

  double dolar;
  double euro;
  double libra;
  double bitcoin;
  double peso;
  double real;
  void _clearAll() {
    realController.text = "";
    dolarController.text = "";
    euroController.text = "";
    libraController.text = "";
    bitcoinController.text = "";
    pesoController.text = "";
  }

  void _realChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    real = double.parse(text);
    dolarController.text = (real / dolar).toStringAsFixed(4);
    euroController.text = (real / euro).toStringAsFixed(4);
    libraController.text = (real / libra).toStringAsFixed(4);
    bitcoinController.text = (real / bitcoin).toStringAsFixed(4);
    pesoController.text = (real / peso).toStringAsFixed(4);
  }

  void _dolarChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    dolar = double.parse(text);
    realController.text = (dolar * this.dolar / real).toStringAsFixed(4);
    euroController.text = (dolar * this.dolar / euro).toStringAsFixed(4);
    libraController.text = (dolar * this.dolar / libra).toStringAsFixed(4);
    bitcoinController.text = (dolar * this.dolar / bitcoin).toStringAsFixed(4);
    pesoController.text = (dolar * this.dolar / peso).toStringAsFixed(4);
  }

  void _euroChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    euro = double.parse(text);
    realController.text = (euro * this.euro).toStringAsFixed(4);
    dolarController.text = (euro * this.euro / dolar).toStringAsFixed(4);
    libraController.text = (euro * this.euro / libra).toStringAsFixed(4);
    bitcoinController.text = (euro * this.euro / bitcoin).toStringAsFixed(4);
    pesoController.text = (euro * this.euro / peso).toStringAsFixed(4);
  }

  void _libraChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
    }
    libra = double.parse(text);
    realController.text = (libra * this.libra).toStringAsFixed(4);
    dolarController.text = (libra * this.libra / dolar).toStringAsFixed(4);
    euroController.text = (libra * this.libra / euro).toStringAsFixed(4);
    bitcoinController.text = (libra * this.libra / bitcoin).toStringAsFixed(4);
    pesoController.text = (libra * this.libra / peso).toStringAsFixed(4);
  }

  void _bitcoinChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
    }
    bitcoin = double.parse(text);
    realController.text = (bitcoin * this.bitcoin).toStringAsFixed(4);
    dolarController.text = (bitcoin * this.bitcoin / dolar).toStringAsFixed(4);
    euroController.text = (bitcoin * this.bitcoin / euro).toStringAsFixed(4);
    libraController.text = (bitcoin * this.bitcoin / libra).toStringAsFixed(4);
    pesoController.text = (bitcoin * this.bitcoin / peso).toStringAsFixed(4);
  }

  void _pesoChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
    }
    peso = double.parse(text);
    realController.text = (peso * this.peso / real).toStringAsFixed(4);
    dolarController.text = (peso * this.peso / dolar).toStringAsFixed(4);
    euroController.text = (peso * this.peso / euro).toStringAsFixed(4);
    libraController.text = (peso * this.peso / libra).toStringAsFixed(4);
    bitcoinController.text = (peso * this.peso / bitcoin).toStringAsFixed(4);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        // appBar: AppBar(
        //   title: Text(
        //     "Value Coin",
        //     style: TextStyle(color: Colors.yellow[900], fontSize: 20.0),
        //   ),
        //   backgroundColor: Colors.white,
        //   centerTitle: true,
        // ),
        body: FutureBuilder<Map>(
            future: getData(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                      child: Text(
                    "Aguarde...",
                    style: TextStyle(color: Colors.white, fontSize: 30.0),
                    textAlign: TextAlign.center,
                  ));
                default:
                  if (snapshot.hasError) {
                    return Center(
                        child: Text(
                      "Ops, houve uma falha ao buscar os dados",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ));
                  } else {
                    dolar =
                        snapshot.data["results"]["currencies"]["USD"]["buy"];
                    euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                    libra =
                        snapshot.data["results"]["currencies"]["GBP"]["buy"];
                    bitcoin =
                        snapshot.data["results"]["currencies"]["BTC"]["buy"];
                    peso = snapshot.data["results"]["currencies"]["ARS"]["buy"];

                    return SingleChildScrollView(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            margin:
                                const EdgeInsets.only(top: 30.0, bottom: 40.0),
                            child: Text(
                              'Quote Coin',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 25.0),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          buildTextField("Dollars", "US\$ ", dolarController,
                              _dolarChanged),
                          Divider(),
                          buildTextField(
                              "Euros", "€ ", euroController, _euroChanged),
                          Divider(),
                          buildTextField(
                              "Reais", "R\$ ", realController, _realChanged),
                          Divider(),
                          buildTextField(
                              "Pound", "£ ", libraController, _libraChanged),
                          Divider(),
                          buildTextField("Bitcoin", "Ƀ ", bitcoinController,
                              _bitcoinChanged),
                          Divider(),
                          buildTextField(
                              "Peso", "\$ ", pesoController, _pesoChanged),
                        ],
                      ),
                    );
                  }
              }
            }));
  }
}

Widget buildTextField(
    String label, String prefix, TextEditingController c, Function f) {
  return TextField(
    controller: c,
    decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(),
        prefixText: prefix),
    style: TextStyle(color: Colors.white, fontSize: 25.0),
    onChanged: f,
    keyboardType: TextInputType.numberWithOptions(decimal: true),
  );
}
