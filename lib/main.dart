import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";

  void _resetFild() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      if (imc < 18.5) {
        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(4)})";
      }else if(imc >=18.5 && imc < 24.9){
        _infoText = "Peso ideal! (${imc.toStringAsPrecision(4)})";
      }else if(imc >=25.0 && imc < 29.9){
        _infoText = "Sobrepeso Grau I (${imc.toStringAsPrecision(4)})";
      }else if(imc >=30.0 && imc < 39.9){
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      }else if(imc >=40){
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.purple,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFild,
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(Icons.person_outline, size: 120.0, color: Colors.purple),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Peso (Kg)",
                      labelStyle: TextStyle(color: Colors.purple)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.purple, fontSize: 25.0),
                  controller: weightController,
                  // ignore: missing_return
                  validator: (value) {
                    // ignore: missing_return
                    if (value.isEmpty) {
                      return "Insira Seu Peso!";
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Altura (cm)",
                      labelStyle: TextStyle(color: Colors.purple)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.purple, fontSize: 25.0),
                  controller: heightController,
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Insira Sua Altura!";
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                    height: 50,
                    child: RaisedButton(
                      onPressed: (){
                        if(_formKey.currentState.validate()){
                          _calculate();
                        }
                      },
                      child: Text(
                        "Calcular",
                        style: TextStyle(color: Colors.white, fontSize: 25.0),
                      ),
                      color: Colors.purple,
                    ),
                  ),
                ),
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.purple, fontSize: 25.0),
                ),
              ],
            ),
          ),
        ));
  }
}
