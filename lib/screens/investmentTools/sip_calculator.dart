import 'package:financialcalc/screens/investmentTools/SIP_Calculator_UTILS/sip_summary.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';

import 'package:flutter/services.dart';

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
  double estimatedReturns = 0.0;

  String formatLargeNumber(double value){
    // format large numbers with suffixes K, M, B
    if (value >= 10000000) {
      return "${(value / 10000000).toStringAsFixed(1)}Cr";  // Millions
    } else if (value >= 100000) {
      return "${(value / 100000).toStringAsFixed(1)}L";  // Lakhs
    } else if (value >= 1000) {
      return "${(value / 1000).toStringAsFixed(1)}K";  // Thousands
    } else {
      return value.toStringAsFixed(2);
    }
  }

  void calculateSIP() {
    final double? amount = double.tryParse(amountController.text);
    final double? rate = double.tryParse(rateController.text);
    final double? time = double.tryParse(timeController.text);

    if (amount == null || rate == null || time == null) return;

    final double monthlyRate = rate / 12 / 100;

    final int months = (time * 12).toInt();

    double fv = amount * ((pow(1 + monthlyRate, months) - 1) / monthlyRate);
    double invested = amount * months;
    double returns = fv - invested;

    setState(() {
      futureValue = fv;
      totalInvested = invested;
      estimatedReturns = returns;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SIP Calculator")),
      body: Padding(padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Monthly SIP Details",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
                ),
                const SizedBox(height: 16,),
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Monthly Investment (₹)",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.currency_rupee)
                  ),
                  onEditingComplete: calculateSIP,
                ),
                const SizedBox(height: 12,),
                TextField(
                  controller: rateController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Expected Annual Return (%)",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.percent)
                  ),
                  onEditingComplete: calculateSIP,
                ),
                const SizedBox(height: 12,),
                TextField(
                  controller: timeController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Duration (Years)",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.calendar_today)
                  ),
                  onEditingComplete: calculateSIP
                ),
                const SizedBox(height: 20,),

                ElevatedButton(onPressed: calculateSIP, child: Text("Calculate")),
                // Result Card
                if (futureValue> 0)
                  SIPSummaryCard(totalInvested: totalInvested, estimatedReturns: estimatedReturns, futureValue: futureValue,)
                  // Card(
                  //   color: Colors.teal.shade50,
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(16)
                  //   ),
                  //   elevation: 4,
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(16.0),
                  //     child: Column(
                  //       children: [
                  //         const Text("SIP Summary",
                  //         style: TextStyle(
                  //           fontSize : 10,
                  //           fontWeight : FontWeight.bold,
                  //           color : Colors.teal
                  //         ),
                  //         ),
                  //         const Divider(),
                  //         ListTile(
                  //           leading: const Icon(Icons.account_balance_wallet,
                  //           color: Colors.teal
                  //           ),
                  //           title: const Text("Total Invested"),
                  //           trailing: Text("₹${formatLargeNumber(totalInvested)}"),
                  //         ),
                  //         ListTile(
                  //           leading: const Icon(Icons.trending_up,
                  //           color: Colors.green
                  //           ),
                  //           title: const Text("Estimated Returns"),
                  //           trailing: Text("₹${formatLargeNumber(estimatedReturns)}"),
                  //         ),
                  //         ListTile(
                  //           leading: const Icon(Icons.savings, color: Colors.blue,),
                  //           title: const Text("Future Value"),
                  //           trailing: Text("₹${formatLargeNumber(futureValue)}"),
                  //         )
                  //       ],
                  //     )
                  //   )
                  //
                  // )
              ],
            ),
          )
      ),
    );
  }
}
