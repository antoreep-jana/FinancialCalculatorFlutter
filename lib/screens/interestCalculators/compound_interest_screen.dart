import 'package:flutter/material.dart';
import 'dart:math';

class CompoundInterestScreen extends StatefulWidget {
  const CompoundInterestScreen({super.key});

  @override
  State<CompoundInterestScreen> createState() => _CompoundInterestScreenState();
}

class _CompoundInterestScreenState extends State<CompoundInterestScreen> {
  final TextEditingController _principalController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  String _selectedFrequency = 'Yearly';
  double? _compoundInterest;
  double? _totalAmount;

  final Map<String, int> _frequencyMap = {
    'Yearly': 1,
    'Half-Yearly': 2,
    'Quarterly': 4,
    'Monthly': 12,
  };

  void _calculateCI() {
    final double principal = double.tryParse(_principalController.text) ?? 0;
    final double rate = double.tryParse(_rateController.text) ?? 0;
    final double time = double.tryParse(_timeController.text) ?? 0;
    final int n = _frequencyMap[_selectedFrequency] ?? 1;

    if (principal > 0 && rate > 0 && time > 0) {
      final double amount = principal * pow((1 + rate / (100 * n)), n * time);
      final double ci = amount - principal;

      setState(() {
        _compoundInterest = ci;
        _totalAmount = amount;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3f6fa),
      appBar: AppBar(
        title: const Text('Compound Interest Calculator'),
        backgroundColor: const Color(0xff1976d2),
        elevation: 3,
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
                      onChanged: (_) => _calculateCI(),
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
                      onChanged: (_) => _calculateCI(),
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
                      onChanged: (_) => _calculateCI(),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: _selectedFrequency,
                      items: _frequencyMap.keys
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (value) {
                        setState(() => _selectedFrequency = value!);
                        _calculateCI();
                      },
                      decoration: const InputDecoration(
                        labelText: 'Compounding Frequency',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.schedule),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            if (_compoundInterest != null)
              Card(
                color: Colors.white,
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        'Compound Interest: ₹${_compoundInterest!.toStringAsFixed(2)}',
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
