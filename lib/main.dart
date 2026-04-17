import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: App()));
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  double financiamento = 0.0;
  double juros = 0.0;
  double parcelas = 0;
  double demais = 0.0;
  double valorFinal = 0.0;
  double valorParcela = 0.0;
  bool resultadoVisivel = false;

  void calcular() {
    valorFinal = financiamento * pow((1 + (juros / 100)), parcelas) + demais;
    valorParcela = parcelas > 0 ? valorFinal / parcelas : 0;
    setState(() {
      resultadoVisivel = true;
    });
  }

  void alert(BuildContext context, String msg) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text("Resultado"),
          content: Text(msg),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Simulador de Financiamento",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF87CEEB), 
      ),
      body: Container(
        color: Color(0xFFF0F8FF),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Valor do financiamento:",
                  style: TextStyle(color: Color(0xFF4682B4)), 
                ),
                const SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Digite o valor",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (v) => financiamento = double.tryParse(v) ?? 0,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Taxa de juros ao mês:",
                  style: TextStyle(color: Color(0xFF4682B4)), 
                ),
                const SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Digite a taxa de juros",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (v) => juros = double.tryParse(v) ?? 0,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Número de parcelas:",
                  style: TextStyle(color: Color(0xFF4682B4)), 
                ),
                const SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Digite o número de parcelas",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (v) => parcelas = double.tryParse(v) ?? 0,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Demais taxas e custos:",
                  style: TextStyle(color: Color(0xFF4682B4)), 
                ),
                const SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Digite o total de taxas e custos adicionais",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (v) => demais = double.tryParse(v) ?? 0,
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () {
                    calcular();
                    alert(
                      context,
                      "Valor total a ser pago: R\$ ${valorFinal.toStringAsFixed(2)}\n"
                      "Valor da parcela: R\$ ${valorParcela.toStringAsFixed(2)}",
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4682B4), 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 12,
                    ),
                  ),
                  child: const Text(
                    "Calcular",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 25),
                if (resultadoVisivel)
                  Column(
                    children: [
                      Text(
                        "Valor total a ser pago: R\$ ${valorFinal.toStringAsFixed(2)}",
                        style: TextStyle(color: Color(0xFF4682B4)), 
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Valor da parcela: R\$ ${valorParcela.toStringAsFixed(2)}",
                        style: TextStyle(color: Color(0xFF4682B4)), 
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}