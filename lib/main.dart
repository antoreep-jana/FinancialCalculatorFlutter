// import 'package:flutter/material.dart';
// import 'screens/home_screen.dart';
//
// void main() {
//
//   runApp(const FinancialCalculatorApp());
//
// }
//
//
// class FinancialCalculatorApp extends StatelessWidget {
//   const FinancialCalculatorApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Financial Calculator',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         scaffoldBackgroundColor: const Color(0xFFF9FAFB),
//         colorSchemeSeed: const Color(0xFF5950EC),
//         useMaterial3: true,
//       ),
//       home: const HomeScreen(),
//     );
//   }
// }

// TODO: Theme Uniformity

import 'package:financial_calculator/screens/home_screen.dart';
import 'package:flutter/material.dart';

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
        themeMode: ThemeMode.system,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.light(
            primary: Colors.deepPurple.shade400, // matches LoanCalculatorsPage
            secondary: Colors.teal.shade400,
            surface: const Color(0xFFF7F7F9),
            onSurface: Colors.grey.shade900,
          ),
          scaffoldBackgroundColor: const Color(0xFFF9FAFB),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(fontFamily: 'Roboto', fontSize: 16),
            titleLarge: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          appBarTheme: AppBarTheme(
            // backgroundColor: Colors.deepPurple.shade400,
            // foregroundColor: Colors.white,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black87,
            elevation: 2,
          ),
        ),
        darkTheme: ThemeData(
          appBarTheme: AppBarTheme(backgroundColor: Colors.black54,),
          brightness: Brightness.dark,
          useMaterial3: true,
          colorScheme: ColorScheme.dark(
            primary: Colors.deepPurple.shade300,
            secondary: Colors.tealAccent.shade200,
            surface: Colors.black87,
            onSurface: Colors.white,
            tertiary: Colors.white10

          ),

        textTheme: TextTheme(
          // Headings & Titles
          headlineLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color : Colors.white
          ),
          headlineMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color : Colors.white70
          ),
          headlineSmall: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white60
          ),

          // Body Text
          bodyLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Colors.white
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color : Colors.white54
          ),
          // Caption & Small text

          bodySmall : TextStyle(
            fontSize: 12,
            color: Colors.white38
          ),


        )
        ),
      home: const HomeScreen(),
    );
  }
}
