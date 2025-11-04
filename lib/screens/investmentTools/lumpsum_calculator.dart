// import 'package:financial_calculator/screens/investmentTools/widgets/lumpsum_summary_card.dart';
// import 'package:flutter/material.dart';
// import 'dart:math';
// import 'package:intl/intl.dart';
//
// class LumpSumInvestmentPage extends StatefulWidget {
//   const LumpSumInvestmentPage({super.key});
//
//   @override
//   State<LumpSumInvestmentPage> createState() => _LumpSumInvestmentPageState();
// }
//
// class _LumpSumInvestmentPageState extends State<LumpSumInvestmentPage> {
//
//   final _formKey = GlobalKey<FormState>();
//
//   TextEditingController _principalController = TextEditingController();
//   TextEditingController _rateController = TextEditingController();
//   TextEditingController _durationController = TextEditingController();
//
//   double? _futureValue;
//
//   double calculateFutureValue(double principal, double rate, double time){
//
//     //return pow(principal * (1 + rate / 100),time);
//     return principal * pow(1 + rate/100, time).toDouble();
//   }
//
//   String formatWithCommas(double value){
//     final formatter = NumberFormat('#,##,###');
//     return formatter.format(value);
//   }
//
//   //Convert number to Thousands, Lakhs, Crores
//   String formatWithUnits(double value){
//
//     if (value >= 10000000){
//       return "${(value/10000000).toStringAsFixed(2)} Cr";
//     }else if(value >= 100000){
//       return "${(value / 100000).toStringAsFixed(2)} L";
//     }else if(value >= 1000){
//       return "${(value / 1000).toStringAsFixed(2)} K";
//     }else{
//       return "${value.toStringAsFixed(2)}";
//     }
//
//   }
//
//   @override
//   void initState(){
//     super.initState();
//
//     // Adding a listener for real time comma formatting
//     _principalController.addListener((){
//       String text = _principalController.text.replaceAll(",", "");
//       if (text.isEmpty) return;
//
//       double value = double.tryParse(text) ?? 0;
//       String formatted = NumberFormat('#,##,###').format(value);
//
//       // Update the text only if it changed
//       if(formatted != _principalController.text){
//         _principalController.value = TextEditingValue(
//           text: formatted,
//           selection: TextSelection.collapsed(offset: formatted.length)
//         );
//       }
//     });
//   }
//
//   @override
//   void dispose()
//   {
//     _principalController.dispose();
//     _rateController.dispose();
//     _durationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Lumpsum Calculator"),
//         backgroundColor: Colors.teal,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               // TextFormField(
//               //   decoration: InputDecoration(labelText: "Enter your name"),
//               //   validator: (value){
//               //     return "Please enter some text";
//               //   },
//               // ),
//               // ElevatedButton(onPressed: (){
//               //   if(_formKey.currentState!.validate()){
//               //     _formKey.currentState!.save();
//               //   }
//               // }, child: Text("Submit"))
//
//               // Principal Amount Input
//               TextFormField(
//                 controller: _principalController,
//                 decoration: InputDecoration(
//                   labelText: "Initial Investment (₹)",
//                   border: OutlineInputBorder()
//                 ),
//                 keyboardType: TextInputType.number,
//                 validator: (value){
//                   if (value == null || value.isEmpty){
//                     return "Please enter an initial Investment";
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16,),
//               //Rate of return input
//               TextFormField(
//                 controller: _rateController,
//                 decoration: InputDecoration(
//                   labelText: "Annual Rate of Return (%)",
//                   border: OutlineInputBorder()
//                 ),
//                 keyboardType: TextInputType.number,
//                 validator: (value){
//                   if (value == null || value.isEmpty){
//                     return "Please enter annual rate of return";
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16,),
//               // Investment duration input
//               TextFormField(
//                 controller: _durationController,
//                 decoration: InputDecoration(
//                   labelText: "Investment Duration (Years)",
//                   border: OutlineInputBorder()
//                 ),
//                 keyboardType: TextInputType.number,
//                 validator: (value){
//                   if(value == null || value.isEmpty){
//                     return "Please enter the investment duration";
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 32),
//
//               // Calculate Button
//               ElevatedButton(onPressed: (){
//                 if (_formKey.currentState!.validate()){
//                   // String text = _principalController.text.replaceAll(",", "");
//                   double principal = double.parse(_principalController.text.replaceAll(",", ""));
//                   double rate = double.parse(_rateController.text);
//                   double duration = double.parse(_durationController.text);
//
//                   print("Principal == $principal");
//                   print("RATE == $rate");
//                   print("Duration == $duration");
//
//                   setState(() {
//                     _futureValue = calculateFutureValue(principal,rate,duration);
//                   });
//
//                   print("FUTURE VALUE CALCULATED -> $_futureValue");
//                 }
//               }, child: Text("Calculate"),
//               style: ElevatedButton.styleFrom(
//                   foregroundColor: Colors.teal,
//                   backgroundColor: Colors.white
//               ),
//               ),
//               SizedBox(height: 32,),
//
//               // Display Result
//               if (_futureValue != null)
//                 // Text("$_futureValue")
//                 LumpsumSummaryCard(futureValue: _futureValue ?? 0.0)//, principal: double.tryParse(_principalController.text), rate : double.tryParse(_rateController.text), duration : double.tryParse(_durationController.text),)
//
//                 // Text("Future Value: ₹${_futureValue!.toStringAsFixed(2)}",
//                 // Text("Future Value: ₹${formatWithUnits(_futureValue!)}",
//                 // style: TextStyle(
//                 //   fontSize: 18,
//                 //   fontWeight: FontWeight.bold,
//                 //   color: Colors.teal
//                 // )
//                 // )
//
//             ],
//           )
//         )
//       )
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:financial_calculator/screens/investmentTools/widgets/lumpsum_summary_card.dart';

class LumpSumInvestmentPage extends StatefulWidget {
  const LumpSumInvestmentPage({super.key});

  @override
  State<LumpSumInvestmentPage> createState() => _LumpSumInvestmentPageState();
}

class _LumpSumInvestmentPageState extends State<LumpSumInvestmentPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _principalController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();

  double? _futureValue;

  @override
  void initState() {
    super.initState();
    _principalController.addListener(_formatPrincipalInput);
  }

  void _formatPrincipalInput() {
    String text = _principalController.text.replaceAll(",", "");
    if (text.isEmpty) return;

    double value = double.tryParse(text) ?? 0;
    String formatted = NumberFormat('#,##,###').format(value);

    if (formatted != _principalController.text) {
      _principalController.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }
  }

  double _calculateFutureValue(double principal, double rate, double years) {
    return principal * pow(1 + rate / 100, years).toDouble();
  }

  @override
  void dispose() {
    _principalController.dispose();
    _rateController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  void _onCalculate() {
    if (_formKey.currentState!.validate()) {
      double principal =
      double.parse(_principalController.text.replaceAll(",", ""));
      double rate = double.parse(_rateController.text);
      double duration = double.parse(_durationController.text);

      setState(() {
        _futureValue = _calculateFutureValue(principal, rate, duration);
      });
    }
  }

  InputDecoration _inputDecoration(String label, ThemeData theme) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.white70, fontSize: 14),
      filled: true,
      // fillColor: Colors.grey.shade900,

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
  print(theme);
    return Scaffold(
      // backgroundColor: theme.colorScheme.surface,
      // backgroundColor: ,
      appBar: AppBar(
        title: Text("Lumpsum Calculator"),
        backgroundColor: theme.colorScheme.surface,
        foregroundColor: theme.colorScheme.onSurface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // Principal
                  TextFormField(
                    controller: _principalController,
                    decoration: _inputDecoration("Initial Investment (₹)", theme),
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.white),
                    validator: (value) =>
                    value == null || value.isEmpty ? "Enter initial investment" : null,
                  ),
                  SizedBox(height: 16),

                  // Rate of Return
                  TextFormField(
                    controller: _rateController,
                    decoration: _inputDecoration("Annual Rate of Return (%)", theme),
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.white),
                    validator: (value) =>
                    value == null || value.isEmpty ? "Enter annual rate of return" : null,
                  ),
                  SizedBox(height: 16),

                  // Investment Duration
                  TextFormField(
                    controller: _durationController,
                    decoration: _inputDecoration("Investment Duration (Years)", theme),
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.white),
                    validator: (value) =>
                    value == null || value.isEmpty ? "Enter investment duration" : null,
                  ),
                  SizedBox(height: 24),

                  // Calculate Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _onCalculate,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.tealAccent.shade700,
                        foregroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: Text(
                        "Calculate",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),

            // Result Card
            if (_futureValue != null)
              AnimatedSwitcher(
                duration: Duration(milliseconds: 400),
                transitionBuilder: (child, animation) =>
                    ScaleTransition(scale: animation, child: child),
                child: LumpsumSummaryCard(
                  key: ValueKey(_futureValue),
                  futureValue: _futureValue!,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
