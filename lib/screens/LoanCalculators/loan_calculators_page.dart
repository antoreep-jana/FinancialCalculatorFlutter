import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math';

class LoanCalculatorsPage extends StatelessWidget {
  const LoanCalculatorsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.light(
          primary: Colors.deepPurple.shade400,
          secondary: Colors.teal.shade400,
          surface: const Color(0xFFF7F7F9),
          onSurface: Colors.grey.shade900,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Roboto', fontSize: 16),
          titleLarge: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.deepPurple.shade400,
          foregroundColor: Colors.white,
          elevation: 2,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        colorScheme: ColorScheme.dark(
          primary: Colors.deepPurple.shade300,
          secondary: Colors.tealAccent.shade200,
        ),
      ),
      home: const LoanCalculatorScreen(),
    );
  }
}

class LoanCalculatorScreen extends StatefulWidget {
  const LoanCalculatorScreen({Key? key}) : super(key: key);

  @override
  _LoanCalculatorScreenState createState() => _LoanCalculatorScreenState();
}

class _LoanCalculatorScreenState extends State<LoanCalculatorScreen> {
  double _loanAmount = 10000;
  double _interestRate = 5;
  double _loanTerm = 12;
  double _monthlyPayment = 0;
  double _totalRepayment = 0;
  double _totalInterest = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: const Text('Loan Calculator', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 24),),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 15, // smaller, sleeker arrow
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),//Navigator.of(context).maybePop(),
          tooltip: 'Back',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_rounded, color: Colors.white),
            tooltip: 'Share Result',
            onPressed: () {
              final snackBar = SnackBar(
                content: Text(
                  _monthlyPayment > 0
                      ? 'Share this result: Monthly payment \$${_monthlyPayment.toStringAsFixed(2)}'
                      : 'Please calculate a loan first!',
                ),
                duration: const Duration(seconds: 2),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ).animate().fadeIn(duration: 300.ms, delay: 200.ms),
          IconButton(
            icon: const Icon(Icons.history_rounded, color: Colors.white),
            tooltip: 'Calculation History',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('History feature coming soon!'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ).animate().fadeIn(duration: 300.ms, delay: 300.ms),
          const SizedBox(width: 8),
        ],
        backgroundColor: Colors.black87,
        elevation: 2,
      ),


      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLoanAmountSlider(textColor),
            const SizedBox(height: 20),
            _buildInterestRateSlider(textColor),
            const SizedBox(height: 20),
            _buildLoanTermSlider(textColor),
            const SizedBox(height: 30),
            _buildCalculateButton(),
            const SizedBox(height: 25),
            _buildResultCard(context),
            const SizedBox(height: 25),
            Align(
              alignment: Alignment.centerRight,
              child: _buildFloatingActionButton(),
            ),
          ],
        ),
      ),
    );
  }

  // --- Sliders ---
  Widget _buildLoanAmountSlider(Color textColor) {
    return Slidable(
      child: _sliderSection(
        title: 'Loan Amount (\$)',
        value: _loanAmount,
        min: 1000,
        max: 50000,
        activeColor: Colors.deepPurple.shade400,
        onChanged: (v) => setState(() => _loanAmount = v),
        label: '\$${_loanAmount.toStringAsFixed(0)}',
        textColor: textColor,
      ),
    );
  }

  Widget _buildInterestRateSlider(Color textColor) {
    return _sliderSection(
      title: 'Interest Rate (%)',
      value: _interestRate,
      min: 1,
      max: 20,
      activeColor: Colors.teal.shade400,
      onChanged: (v) => setState(() => _interestRate = v),
      label: '${_interestRate.toStringAsFixed(1)}%',
      textColor: textColor,
    );
  }

  Widget _buildLoanTermSlider(Color textColor) {
    return _sliderSection(
      title: 'Loan Term (Months)',
      value: _loanTerm,
      min: 6,
      max: 60,
      activeColor: Colors.indigo.shade400,
      onChanged: (v) => setState(() => _loanTerm = v),
      label: '${_loanTerm.toStringAsFixed(0)} Months',
      textColor: textColor,
    );
  }

  Widget _sliderSection({
    required String title,
    required double value,
    required double min,
    required double max,
    required Color activeColor,
    required Function(double) onChanged,
    required String label,
    required Color textColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: textColor)),
        Slider(
          value: value,
          min: min,
          max: max,
          onChanged: onChanged,
          activeColor: activeColor,
          inactiveColor: Colors.grey.shade400,
        ),
        Text(label,
            style: TextStyle(
                fontFamily: 'Roboto', fontSize: 18, color: textColor)),
      ],
    );
  }

  // --- Calculate Button ---
  Widget _buildCalculateButton() {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple.shade400,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        ),
        onPressed: _calculateLoan,
        child: const Text(
          'Calculate',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ).animate().fadeIn(duration: 400.ms).move(
      delay: 500.ms,
      duration: 500.ms,
      begin: const Offset(0, 10),
    );
  }

  // --- Calculation Logic ---
  void _calculateLoan() {
    setState(() {
      double rate = _interestRate / 100 / 12;
      int months = _loanTerm.toInt();
      _monthlyPayment = (_loanAmount * rate) / (1 - pow((1 + rate), -months));
      _totalRepayment = _monthlyPayment * months;
      _totalInterest = _totalRepayment - _loanAmount;
    });
  }

  // --- Result Card ---
  Widget _buildResultCard(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.light
            ? Colors.white
            : Colors.grey.shade900,
        borderRadius: BorderRadius.circular(16),
        boxShadow: theme.brightness == Brightness.light
            ? [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ]
            : [],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Loan Summary',
              style: theme.textTheme.titleLarge!.copyWith(
                color: theme.colorScheme.primary,
              )),
          const SizedBox(height: 12),
          _resultRow('Monthly Payment', '\$${_monthlyPayment.toStringAsFixed(2)}', theme),
          _resultRow('Total Interest', '\$${_totalInterest.toStringAsFixed(2)}', theme),
          _resultRow('Total Repayment', '\$${_totalRepayment.toStringAsFixed(2)}', theme),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms);
  }

  Widget _resultRow(String label, String value, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: theme.textTheme.bodyLarge!.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              )),
          Text(value,
              style: theme.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.primary,
              )),
        ],
      ),
    );
  }

  // --- Floating Action Button ---
  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: Colors.deepPurple.shade400,
      child: const Icon(FontAwesomeIcons.infoCircle, color: Colors.white),
    ).animate().effect(duration: 500.ms, curve: Curves.easeOutBack);
  }
}
