import 'package:financialcalc/screens/investmentTools/sip_calculator.dart';
import 'package:flutter/material.dart';

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
        'onTap': () {}, // Placeholder for future
      },
      {
        'title': 'Goal Calculator',
        'description': 'Plan how much to invest monthly to reach your goal.',
        'icon': Icons.flag_outlined,
        'onTap': () {}, // Placeholder for future
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xfff3f6fa),
      appBar: AppBar(
        title: const Text('Investment Tools'),
        backgroundColor: const Color(0xff1976d2),
        elevation: 3,
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
