import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const FinancialCalculatorApp());
}

class FinancialCalculatorApp extends StatelessWidget {

  const FinancialCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Financial Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF9FAFB),
        colorSchemeSeed: const Color(0xFF4F46E5),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
