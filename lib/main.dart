import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async => runApp(
  MaterialApp(
    home: Home(),
    theme: ThemeData(
      hintColor: Colors.green,
      primaryColor: Colors.white
    ),
  ),
);


Future <Map> getData() async{
  String request = "https://api.hgbrasil.com/finance?format=json&key=629f2acc";
  http.Response response = await http.get(request);
  return json.decode(response.body);
} 

class Home extends StatefulWidget{
  _HomeState createState()=> _HomeState();
}

class _HomeState extends State<Home>{
  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();

  double dolar;
  double euro;

  void _clearAll(){
  realController.text = "";
  dolarController.text = "";
  euroController.text = "";
}//funcao para apagar tudo que estiver nos campos de textos

  void _realChanged(String text){
  if(text.isEmpty){
    _clearAll();
  }//caso tenha algo no campo de texto apague tudo

  double real = double.parse(text);
  dolarController.text = (real/dolar).toStringAsFixed(2);
  euroController.text = (real/euro).toStringAsFixed(2);
}
}