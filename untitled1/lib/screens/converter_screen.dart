// lib/screens/converter_screen.dart
import 'package:flutter/material.dart';

class ConverterScreen extends StatefulWidget {
  static const routeName = '/converter';
  const ConverterScreen({super.key});

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  final _controller = TextEditingController();
  String _fromUnit = 'Celsius';
  String _toUnit = 'Fahrenheit';
  double? _output;

  final List<String> _units = ['Celsius', 'Fahrenheit', 'Kelvin'];

  void _convert() {
    final input = double.tryParse(_controller.text);
    if (input == null) return;
    double result;
    // konversi suhu
    if (_fromUnit == 'Celsius' && _toUnit == 'Fahrenheit') {
      result = input * 9 / 5 + 32;
    } else if (_fromUnit == 'Fahrenheit' && _toUnit == 'Celsius') {
      result = (input - 32) * 5 / 9;
    } else if (_fromUnit == 'Celsius' && _toUnit == 'Kelvin') {
      result = input + 273.15;
    } else if (_fromUnit == 'Kelvin' && _toUnit == 'Celsius') {
      result = input - 273.15;
    } else if (_fromUnit == 'Fahrenheit' && _toUnit == 'Kelvin') {
      result = (input - 32) * 5 / 9 + 273.15;
    } else if (_fromUnit == 'Kelvin' && _toUnit == 'Fahrenheit') {
      result = (input - 273.15) * 9 / 5 + 32;
    } else {
      result = input;
    }
    setState(() => _output = result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Konverter Suhu')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  labelText: 'Nilai', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _fromUnit,
                    decoration: const InputDecoration(labelText: 'Dari'),
                    items: _units
                        .map((u) =>
                        DropdownMenuItem(value: u, child: Text(u)))
                        .toList(),
                    onChanged: (v) => setState(() => _fromUnit = v!),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _toUnit,
                    decoration: const InputDecoration(labelText: 'Ke'),
                    items: _units
                        .map((u) =>
                        DropdownMenuItem(value: u, child: Text(u)))
                        .toList(),
                    onChanged: (v) => setState(() => _toUnit = v!),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _convert,
                child: const Text('Konversi'),
              ),
            ),
            const SizedBox(height: 24),
            if (_output != null)
              Text(
                'Hasil: ${_output!.toStringAsFixed(2)} $_toUnit',
                style:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}
