import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  static const routeName = '/calculator';

  final VoidCallback onToggleTheme;
  const CalculatorScreen({Key? key, required this.onToggleTheme}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _input = '';
  String _result = '';
  List<String> _history = [];
  bool _isScientific = false;

  void _onPressed(String value) {
    setState(() {
      if (value == 'C') {
        _input = '';
        _result = '';
      } else if (value == '=') {
        try {
          String finalInput = _input.replaceAll('×', '*').replaceAll('÷', '/').replaceAll('√', 'sqrt').replaceAll('log', 'log');
          Parser p = Parser();
          Expression exp = p.parse(finalInput);
          ContextModel cm = ContextModel();
          double eval = exp.evaluate(EvaluationType.REAL, cm);
          _result = eval.toStringAsFixed(2);
          _history.add('$_input = $_result');
        } catch (e) {
          _result = 'Error';
        }
      } else if (value == 'x²') {
        _input += '^2';
      } else if (value == '√x') {
        _input += 'sqrt(';
      } else if (value == 'xʸ') {
        _input += '^';
      } else if (value == 'log') {
        _input += 'log(';
      } else {
        _input += value;
      }
    });
  }

  Widget _buildButton(String value) {
    return ElevatedButton(
      onPressed: () => _onPressed(value),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(20),
        backgroundColor: Colors.grey[850],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(value, style: const TextStyle(fontSize: 22)),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> baseButtons = [
      '7', '8', '9', '÷',
      '4', '5', '6', '×',
      '1', '2', '3', '-',
      '0', '.', '=', '+',
      'C',
    ];

    List<String> scientificButtons = [
      'x²', '√x', 'xʸ', 'log',
    ];

    List<String> buttons = [
      ...baseButtons,
      if (_isScientific) ...scientificButtons,
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalkulator'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: widget.onToggleTheme,
            tooltip: 'Ganti Tema',
          ),
          IconButton(
            icon: Icon(_isScientific ? Icons.science : Icons.science_outlined),
            tooltip: 'Ganti Mode Kalkulator',
            onPressed: () {
              setState(() {
                _isScientific = !_isScientific;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_forever),
            tooltip: 'Hapus Riwayat',
            onPressed: () {
              setState(() {
                _history.clear();
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.bottomRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(_input, style: const TextStyle(fontSize: 28)),
                  const SizedBox(height: 10),
                  Text(_result, style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          GridView.builder(
            padding: const EdgeInsets.all(10),
            shrinkWrap: true,
            itemCount: buttons.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return _buildButton(buttons[index]);
            },
          ),
          const Divider(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView.builder(
                itemCount: _history.length,
                itemBuilder: (context, index) => Text(_history[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
