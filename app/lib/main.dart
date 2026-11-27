import 'package:flutter/material.dart';
// Подключаем экран, который написал наш робот B
import 'ui/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'СтройКалькулятор 360',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      // Здесь мы говорим приложению: "Запусти экран от робота!"
      home: HomeScreen(), 
    );
  }
}