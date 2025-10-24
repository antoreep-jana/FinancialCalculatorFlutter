import 'package:financialcalc/database/db_helper.dart';
import 'package:financialcalc/screens/history/history_page.dart';
import 'package:flutter/material.dart';


import '../../models/calculation.dart';

class SimpleInterestScreen extends StatefulWidget {
  const SimpleInterestScreen({super.key});

  @override
  State<SimpleInterestScreen> createState() => _SimpleInterestScreenState();
}

class _SimpleInterestScreenState extends State<SimpleInterestScreen> {



  final TextEditingController _principalController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();


  double? _simpleInterest;
  double? _totalAmount;

  void _calculateInterest() {
    final double principal = double.tryParse(_principalController.text) ?? 0;
    final double rate = double.tryParse(_rateController.text) ?? 0;
    final double time = double.tryParse(_timeController.text) ?? 0;

    final double si = (principal * rate * time) / 100;
    final double total = principal + si;

    setState(() {
      _simpleInterest = si;
      _totalAmount = total;
    });
  }

  @override
  void initState(){
    super.initState();

    _principalController.addListener(_onTextChanged);
    _rateController.addListener(_onTextChanged);
    _timeController.addListener(_onTextChanged);

  }

  // Future<void> saveSimpleInterest(double principal, double rate, double time, double si, double amount) async{
  //   await DBHelper().insertData(
  //       InterestData(principal: principal,
  //         rate : rate,
  //         time : time,
  //         result : si,
  //         amount : amount,
  //         type: 'SI'
  //       )
  //   );
  // }

  void _onTextChanged() async{
    final principalText = _principalController.text;
    final rateText = _rateController.text;
    final timeText = _timeController.text;

    if (principalText.isNotEmpty && rateText.isNotEmpty && timeText.isNotEmpty){
      final principal = double.tryParse(principalText);
      final rate = double.tryParse(rateText);
      final time = double.tryParse(timeText);

      if (principal != null && rate != null && time != null){
        final si = (principal * rate * time) / 100;
        final amount = principal + si;

        setState(() {
          _simpleInterest = si;
          _totalAmount =  amount;//si + principal;
        });

        await DBHelper.instance.insertData(
            InterestData.fromMap({
              'principal': principal,
              'rate': rate,
              'time': time,
              'result': si,
              'amount': amount,
              "type": "SI"}
            )
        );

        // saveSimpleInterest(principal, rate, time,si, amount );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3f6fa),
      appBar: AppBar(
        title: const Text('Simple Interest Calculator'),
        backgroundColor: const Color(0xff1976d2),
        elevation: 3,

        actions: [
          IconButton(onPressed: (){

            Navigator.push(context, 
            MaterialPageRoute(builder: (context)=> HistoryPage())
            );
          }, icon: Icon(Icons.history))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextField(
                      controller: _principalController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Principal Amount (₹)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.account_balance_wallet_outlined),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _rateController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Rate of Interest (%)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.percent),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _timeController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Time (Years)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.access_time),
                      ),
                    ),
                    const SizedBox(height: 24),


                    // SizedBox(
                    //   width: double.infinity,
                    //   child: ElevatedButton(
                    //     onPressed: _calculateInterest,
                    //     style: ElevatedButton.styleFrom(
                    //       backgroundColor: const Color(0xff1976d2),
                    //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    //       padding: const EdgeInsets.symmetric(vertical: 14),
                    //     ),
                    //     child: const Text(
                    //       'Calculate',
                    //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            if (_simpleInterest != null)
              Card(
                color: Colors.white,
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        'Simple Interest: ₹${_simpleInterest!.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Total Amount: ₹${_totalAmount!.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
