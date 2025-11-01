// import 'package:financialcalc/screens/investmentTools/lumpsum_calculator.dart';
// import 'package:financialcalc/screens/investmentTools/sip_calculator.dart';
import 'package:financial_calculator/screens/investmentTools/swp_calculator.dart';
import 'package:flutter/material.dart';

import 'lumpsum_calculator.dart';
import 'sip_calculator.dart';

class InvestmentToolsPage extends StatelessWidget {
  const InvestmentToolsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> investmentTools = [
      {
        'title': 'SIP Calculator',
        'description': 'Calculate expected returns for Systematic Investment Plans.',
        'icon': Icons.trending_up_outlined,
        'onTap': () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => SipCalculator()));
        }
      },
      {
        'title': 'Lumpsum Calculator',
        'description': 'Estimate future value of a one-time investment.',
        'icon': Icons.savings_outlined,
        'onTap': () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => LumpSumInvestmentPage()));

        }, // Placeholder for future
      },
      {
        'title': 'Goal Calculator',
        'description': 'Plan how much to invest monthly to reach your goal.',
        'icon': Icons.flag_outlined,
        'onTap': () {}, // Placeholder for future
      },
      {
        "title" : "SWP Calculator",
        "description" : "Calculate the monthly withdrawals from your investments through Systematic Withdrawl Plans (SWP)",
        "icon" :
          Icons.monetization_on, // A simple money icon
          // size: 30, // Set size of the icon
          // color: Colors.blue, // Set the color of the icon

        "onTap" : (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => SWPCalculator()));
        }
      }
    ];

    return Scaffold(
      backgroundColor: const Color(0xfff3f6fa),
      appBar: AppBar(
        title: const Text('Investment Tools',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xff1976d2),
        elevation: 3,
        shadowColor: Colors.lightBlueAccent,

      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: investmentTools.length,
        itemBuilder: (context, index) {
          final tool = investmentTools[index];
          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: const Color(0xff1976d2).withOpacity(0.1),
                child: Icon(tool['icon'], color: const Color(0xff1976d2)),
              ),
              title: Text(
                tool['title'],
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                tool['description'],
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
              trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 18, color: Colors.grey),
              onTap: tool['onTap'],
            ),
          );
        },
      ),
    );
  }
}
