// // import 'package:financialcalc/screens/investmentTools/widgets/sip_summary_card.dart';
// import 'package:financial_calculator/screens/investmentTools/widgets/sip_summary_card.dart';
// import 'package:flutter/material.dart';
// import 'dart:math';
// import 'package:intl/intl.dart';
//
// import 'package:flutter/services.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
//
// class SipCalculator extends StatefulWidget {
//   const SipCalculator({super.key});
//
//   @override
//   State<SipCalculator> createState() => _SipCalculatorState();
// }
//
// class _SipCalculatorState extends State<SipCalculator> {
//   final TextEditingController amountController = TextEditingController();
//   final TextEditingController rateController = TextEditingController();
//   final TextEditingController timeController = TextEditingController();
//
//   double futureValue = 0.0;
//   double totalInvested = 0.0;
//   double estimatedReturns = 0.0;
//   String currencySymbol = "₹";  // Default to Rupee sign
//
//   @override
//   void initState(){
//     super.initState();
//     _loadCurrencySymbol();
//   }
//
//   // Load Currency symbol from shared preferences
//   _loadCurrencySymbol() async{
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       currencySymbol = prefs.getString("currencySymbol") ?? "₹";  // Default to Rupee sign"
//     });
//   }
//
//   String formatLargeNumber(double value){
//     // format large numbers with suffixes K, M, B
//
//     // Check if the currency system is INR
//     if (currencySymbol == "₹") {
//       if (value >= 10000000) {
//         return "${(value / 10000000).toStringAsFixed(1)}Cr"; // Millions
//       } else if (value >= 100000) {
//         return "${(value / 100000).toStringAsFixed(1)}L"; // Lakhs
//       } else if (value >= 1000) {
//         return "${(value / 1000).toStringAsFixed(1)}K"; // Thousands
//       } else {
//         return value.toStringAsFixed(2);
//       }
//     }
//     // Else the american system of currency
//     else{
//       if(value >= 1000000000){
//         return "${(value / 1000000000).toStringAsFixed(2)}B"; // Billions
//       }else if (value >= 1000000){
//         return "${(value / 1000000).toStringAsFixed(2)}M"; // Millions
//       }else if (value >= 1000){
//         return "${(value / 1000).toStringAsFixed(2)}K"; // Thousands
//       }else{
//         return value.toStringAsFixed(2);
//       }
//     }
//
//   }
//
//   final Map<String, Icon> icons = {
//     "₹": Icon(Icons.currency_rupee),
//     "\$": Icon(Icons.attach_money),
//     "€": Icon(Icons.euro),
//     "¥": Icon(Icons.monetization_on), // Japanese Yen
//     "£": Icon(Icons.currency_pound), // British Pound (requires specific icon)
//   };
//
//
//   void calculateSIP() {
//     final double? amount = double.tryParse(amountController.text);
//     final double? rate = double.tryParse(rateController.text);
//     final double? time = double.tryParse(timeController.text);
//
//     if (amount == null || rate == null || time == null) return;
//
//     final double monthlyRate = rate / 12 / 100;
//
//     final int months = (time * 12).toInt();
//
//     double fv = amount * ((pow(1 + monthlyRate, months) - 1) / monthlyRate);
//     double invested = amount * months;
//     double returns = fv - invested;
//
//     setState(() {
//       futureValue = fv;
//       totalInvested = invested;
//       estimatedReturns = returns;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("SIP Calculator")),
//       body: Padding(padding: const EdgeInsets.all(16.0),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text("Monthly SIP Details",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
//                 ),
//                 const SizedBox(height: 16,),
//                 TextField(
//                   controller: amountController,
//                   keyboardType: TextInputType.number,
//                   decoration:  InputDecoration(
//                     labelText: "Monthly Investment (${currencySymbol})",
//                     border: OutlineInputBorder(),
//                     prefixIcon: icons[currencySymbol]//Icon()
//                   ),
//                   // onEditingComplete: calculateSIP,
//                 ),
//                 const SizedBox(height: 12,),
//                 TextField(
//                   controller: rateController,
//                   keyboardType: TextInputType.number,
//                   decoration: const InputDecoration(
//                     labelText: "Expected Annual Return (%)",
//                     border: OutlineInputBorder(),
//                     prefixIcon: Icon(Icons.percent)
//                   ),
//                   // onEditingComplete: calculateSIP,
//                 ),
//                 const SizedBox(height: 12,),
//                 TextField(
//                   controller: timeController,
//                   keyboardType: TextInputType.number,
//                   decoration: const InputDecoration(
//                     labelText: "Duration (Years)",
//                     border: OutlineInputBorder(),
//                     prefixIcon: Icon(Icons.calendar_today)
//                   ),
//                   // onEditingComplete: calculateSIP
//                 ),
//                 const SizedBox(height: 20,),
//
//                 ElevatedButton(onPressed: calculateSIP, child: Text("Calculate")),
//                 // Result Card
//                 if (futureValue> 0)
//                   SIPSummaryCard(totalInvested: totalInvested, estimatedReturns: estimatedReturns, futureValue: futureValue,)
//
//               ],
//             ),
//           )
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:financial_calculator/screens/investmentTools/widgets/sip_summary_card.dart';

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
  String currencySymbol = "₹"; // Default

  @override
  void initState() {
    super.initState();
    _loadCurrencySymbol();
  }

  // Load currency symbol from shared preferences
  _loadCurrencySymbol() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      currencySymbol = prefs.getString("currencySymbol") ?? "₹";
    });
  }

  String formatLargeNumber(double value) {
    if (currencySymbol == "₹") {
      if (value >= 10000000) return "${(value / 10000000).toStringAsFixed(1)}Cr";
      if (value >= 100000) return "${(value / 100000).toStringAsFixed(1)}L";
      if (value >= 1000) return "${(value / 1000).toStringAsFixed(1)}K";
      return value.toStringAsFixed(2);
    } else {
      if (value >= 1000000000) return "${(value / 1000000000).toStringAsFixed(2)}B";
      if (value >= 1000000) return "${(value / 1000000).toStringAsFixed(2)}M";
      if (value >= 1000) return "${(value / 1000).toStringAsFixed(2)}K";
      return value.toStringAsFixed(2);
    }
  }

  final Map<String, Icon> icons = {
    "₹": const Icon(Icons.currency_rupee),
    "\$": const Icon(Icons.attach_money),
    "€": const Icon(Icons.euro),
    "¥": const Icon(Icons.monetization_on),
    "£": const Icon(Icons.currency_pound),
  };

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
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "SIP Calculator",
          style: textTheme.titleLarge?.copyWith(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Monthly SIP Details",
                style: textTheme.titleLarge?.copyWith(color: colorScheme.primary),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Monthly Investment ($currencySymbol)",
                  border: const OutlineInputBorder(),
                  prefixIcon: icons[currencySymbol],
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: rateController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Expected Annual Return (%)",
                  border: const OutlineInputBorder(),
                  prefixIcon: Icon(Icons.percent, color: colorScheme.primary),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: timeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Duration (Years)",
                  border: const OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today, color: colorScheme.primary),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: calculateSIP,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary, // ensures text/icon is visible
                  ),
                  child: Text("Calculate", ), // no const
                )

              ),
              const SizedBox(height: 20), // add space here

              if (futureValue > 0)
                SIPSummaryCard(
                  totalInvested: totalInvested,
                  estimatedReturns: estimatedReturns,
                  futureValue: futureValue,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
