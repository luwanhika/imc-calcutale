import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";

  

  void _resetField() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      if (imc < 18.6) {
        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente Acima do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 40) {
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
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetField,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.person_outline,
                size: 120,
                color: Colors.amber,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(
                      color: Colors.amber,
                    ),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 25,
                  ),
                  controller: weightController,
                  validator: ( String ? value) {
                    if(value == null || value.isEmpty){
                      return "Insira seu Peso!";
                    }
                  },
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura (cm)",
                  labelStyle: TextStyle(
                    color: Colors.amber,
                  ),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 25,
                ),
                controller: heightController,
                validator: (value) {
                    if(value?.isEmpty ?? false){
                      return "Insira sua Altura!";
                    } else {
                      return null;
                    }
                  },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: Container(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if(_formKey.currentState?.validate() ?? false){
                        _calculate();
                      }
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.amber),
                    ),
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
