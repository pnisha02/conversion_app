import 'package:flutter/material.dart';

void main() {
  runApp(MeasuresConverterApp());
}

class MeasuresConverterApp extends StatelessWidget {
  const MeasuresConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Measures Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MeasuresConverterScreen(),
    );
  }
}

class MeasuresConverterScreen extends StatefulWidget {
  const MeasuresConverterScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MeasuresConverterScreenState createState() =>
      _MeasuresConverterScreenState();
}

class _MeasuresConverterScreenState extends State<MeasuresConverterScreen> {
  final TextEditingController _valueController = TextEditingController();
  String _fromUnit = 'meters';
  String _toUnit = 'feet';
  double? _convertedValue;

  final Map<String, double> _conversionRates = {
    // Base unit: meter
    'meters': 1.0,
    'kilometers': 1000.0,
    'feet': 0.3048,
    'miles': 1609.34,
  };

  void _convert() {
    final inputValue = double.tryParse(_valueController.text);
    if (inputValue == null) {
      setState(() {
        _convertedValue = null;
      });
      return;
    }

    double valueInMeters = inputValue * _conversionRates[_fromUnit]!;
    double convertedValue = valueInMeters / _conversionRates[_toUnit]!;

    setState(() {
      _convertedValue = convertedValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Measures Converter')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Value',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _valueController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter value',

              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'From',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: _fromUnit,
              isExpanded: true,
              items: _conversionRates.keys.map((String unit) {
                return DropdownMenuItem<String>(
                  value: unit,
                  child: Text(unit),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _fromUnit = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'To',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: _toUnit,
              isExpanded: true,
              items: _conversionRates.keys.map((String unit) {
                return DropdownMenuItem<String>(
                  value: unit,
                  child: Text(unit),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _toUnit = value!;
                });
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _convert,
              child: const Text('Convert'),
            ),
            const SizedBox(height: 30),
            if (_convertedValue != null)
              Text(
                '${_valueController.text} $_fromUnit are ${_convertedValue!.toStringAsFixed(3)} $_toUnit',
                style: const TextStyle(fontSize: 18, color: Colors.blue),

                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}