import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    ),
  );
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController weightPerson = TextEditingController();
  final TextEditingController heightPerson = TextEditingController();

  String? resultImc;
  double imc = 0;

  bool get isEditWeightPerson => weightPerson.text.isNotEmpty;
  bool get isEditHeightPerson => heightPerson.text.isNotEmpty;
  bool get resultImcIsNotEmpty => resultImc != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 225, 219, 219),
      appBar: AppBar(
        title: const Text(
          'Calculadora de IMC',
          style: TextStyle(
            fontSize: 22,
          ),
        ),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 30,
        ),
        centerTitle: true,
        backgroundColor: Colors.cyan,
        actions: [
          IconButton(
            onPressed: () {
              setState(
                () {
                  if (resultImcIsNotEmpty) {
                    resultImc = null;
                    imc = 0;
                  }
                },
              );
            },
            icon: const Icon(Icons.refresh_sharp),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person_3_outlined,
                  size: 100,
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: weightPerson,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Peso em KG",
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: heightPerson,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Altura em CM",
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff00d7f3),
                padding: const EdgeInsets.all(18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              onPressed: () {
                setState(
                  () {
                    if (isEditWeightPerson && isEditHeightPerson) {
                      resultImc =
                          "${resultImcText()} \nIMC: ${imc.toStringAsFixed(2)}";

                      heightPerson.clear();
                      weightPerson.clear();
                    }
                  },
                );
              },
              child: const Center(
                child: Text(
                  "Calcular",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Center(
              child: Text(resultImc ?? 'Insira os Dados',
                  style: const TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }

  double calculateImc() {
    double heightPersonDouble = double.parse(heightPerson.text);
    double weightPersonDouble = double.parse(weightPerson.text);

    double heightInMeters = heightPersonDouble / 100;

    return (weightPersonDouble / (heightInMeters * heightInMeters));
  }

  String resultImcText() {
    imc = calculateImc();

    if (imc < 18.5) {
      return "Abaixo do peso";
    } else if (imc >= 18.5 && imc < 24.9) {
      return "Peso normal";
    } else if (imc >= 25 && imc < 29.9) {
      return "Sobrepeso";
    } else if (imc >= 30 && imc < 34.9) {
      return "Obesidade grau I";
    } else if (imc >= 35 && imc < 39.9) {
      return "Obesidade grau II";
    } else if (imc >= 40 && imc < 49.9) {
      return "Obesidade grau III";
    } else if (imc >= 50 && imc < 59.9) {
      return "Obesidade grau IV";
    } else {
      return "Obesidade grau V";
    }
  }
}
