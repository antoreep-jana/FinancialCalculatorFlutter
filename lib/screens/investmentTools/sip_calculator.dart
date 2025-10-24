import 'package:flutter/material.dart';
import 'dart:math';

class SipCalculator extends StatefulWidget {
  const SipCalculator({super.key});

  @override
  State<SipCalculator> createState() => _SipCalculatorState();
}

class _SipCalculatorState extends State<SipCalculator> {

  final TextEditingController amountController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  double futureValue = 0.0;
  double totalInvested = 0.0;
  double estimateReturns = 0.0;

  void calculateSIP(){
    final double? amount = double.tryParse(amountController.text);
    final double? rate = double.tryParse(rateController.text);
    final double? time = double.tryParse(timeController.text);

    if (amount == null || rate == null || time == null) return;

    final double monthlyRate = rate / 12 / 100;

    final int months = (time * 12).toInt();

    double fv = amount * ((pow( 1 + monthlyRate, months) - 1) / monthlyRate);
    double invested = amount * months;
    double returns = fv - invested;


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SIP Calculator"),
      ),
    );
  }
}
