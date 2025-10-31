import 'package:financial_calculator/screens/investmentTools/widgets/lumpsum_summary_card.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';

class LumpSumInvestmentPage extends StatefulWidget {
  const LumpSumInvestmentPage({super.key});

  @override
  State<LumpSumInvestmentPage> createState() => _LumpSumInvestmentPageState();
}

class _LumpSumInvestmentPageState extends State<LumpSumInvestmentPage> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController _principalController = TextEditingController();
  TextEditingController _rateController = TextEditingController();
  TextEditingController _durationController = TextEditingController();

  double? _futureValue;

  double calculateFutureValue(double principal, double rate, double time){

    //return pow(principal * (1 + rate / 100),time);
    return principal * pow(1 + rate/100, time).toDouble();
  }

  String formatWithCommas(double value){
    final formatter = NumberFormat('#,##,###');
    return formatter.format(value);
  }

  //Convert number to Thousands, Lakhs, Crores
  String formatWithUnits(double value){

    if (value >= 10000000){
      return "${(value/10000000).toStringAsFixed(2)} Cr";
    }else if(value >= 100000){
      return "${(value / 100000).toStringAsFixed(2)} L";
    }else if(value >= 1000){
      return "${(value / 1000).toStringAsFixed(2)} K";
    }else{
      return "${value.toStringAsFixed(2)}";
    }

  }

  @override
  void initState(){
    super.initState();

    // Adding a listener for real time comma formatting
    _principalController.addListener((){
      String text = _principalController.text.replaceAll(",", "");
      if (text.isEmpty) return;

      double value = double.tryParse(text) ?? 0;
      String formatted = NumberFormat('#,##,###').format(value);

      // Update the text only if it changed
      if(formatted != _principalController.text){
        _principalController.value = TextEditingValue(
          text: formatted,
          selection: TextSelection.collapsed(offset: formatted.length)
        );
      }
    });
  }

  @override
  void dispose()
  {
    _principalController.dispose();
    _rateController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Lumpsum Calculator"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // TextFormField(
              //   decoration: InputDecoration(labelText: "Enter your name"),
              //   validator: (value){
              //     return "Please enter some text";
              //   },
              // ),
              // ElevatedButton(onPressed: (){
              //   if(_formKey.currentState!.validate()){
              //     _formKey.currentState!.save();
              //   }
              // }, child: Text("Submit"))

              // Principal Amount Input
              TextFormField(
                controller: _principalController,
                decoration: InputDecoration(
                  labelText: "Initial Investment (₹)",
                  border: OutlineInputBorder()
                ),
                keyboardType: TextInputType.number,
                validator: (value){
                  if (value == null || value.isEmpty){
                    return "Please enter an initial Investment";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16,),
              //Rate of return input
              TextFormField(
                controller: _rateController,
                decoration: InputDecoration(
                  labelText: "Annual Rate of Return (%)",
                  border: OutlineInputBorder()
                ),
                keyboardType: TextInputType.number,
                validator: (value){
                  if (value == null || value.isEmpty){
                    return "Please enter annual rate of return";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16,),
              // Investment duration input
              TextFormField(
                controller: _durationController,
                decoration: InputDecoration(
                  labelText: "Investment Duration (Years)",
                  border: OutlineInputBorder()
                ),
                keyboardType: TextInputType.number,
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Please enter the investment duration";
                  }
                  return null;
                },
              ),
              SizedBox(height: 32),

              // Calculate Button
              ElevatedButton(onPressed: (){
                if (_formKey.currentState!.validate()){
                  // String text = _principalController.text.replaceAll(",", "");
                  double principal = double.parse(_principalController.text.replaceAll(",", ""));
                  double rate = double.parse(_rateController.text);
                  double duration = double.parse(_durationController.text);

                  setState(() {
                    _futureValue = calculateFutureValue(principal,rate,duration);
                  });
                }
              }, child: Text("Calculate"),
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.teal,
                  backgroundColor: Colors.white
              ),
              ),
              SizedBox(height: 32,),

              // Display Result
              if (_futureValue != null)
                LumpsumSummaryCard(futureValue: _futureValue!, principal: double.tryParse(_principalController.text)!, rate : double.tryParse(_rateController.text)!, duration : double.tryParse(_durationController.text)!,)

                // Text("Future Value: ₹${_futureValue!.toStringAsFixed(2)}",
                // Text("Future Value: ₹${formatWithUnits(_futureValue!)}",
                // style: TextStyle(
                //   fontSize: 18,
                //   fontWeight: FontWeight.bold,
                //   color: Colors.teal
                // )
                // )

            ],
          )
        )
      )
    );
  }
}
