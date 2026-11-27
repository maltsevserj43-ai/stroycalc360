import 'package:flutter/material.dart';

class RectangleScreen extends StatefulWidget {
  const RectangleScreen({super.key});

  @override
  State<RectangleScreen> createState() => _RectangleScreenState();
}

class _RectangleScreenState extends State<RectangleScreen> {
  final TextEditingController _lengthController = TextEditingController();
  final TextEditingController _widthController = TextEditingController();
  String _result = '';

  void _calculateArea() {
    final length = double.tryParse(_lengthController.text) ?? 0;
    final width = double.tryParse(_widthController.text) ?? 0;
    final area = length * width;
    setState(() {
      _result = 'Площадь: ${area.toStringAsFixed(2)} м²';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Площадь прямоугольника'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _lengthController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Длина (м)', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _widthController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Ширина (м)', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateArea,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Рассчитать', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 20),
            Text(
              _result,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}