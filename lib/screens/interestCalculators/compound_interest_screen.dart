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
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Compound Interest',
          style: textTheme.titleLarge?.copyWith(color: Colors.white),
        ),
        backgroundColor: colorScheme.surface,
        elevation: 3,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              color: colorScheme.surface,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _buildTextField(
                      controller: _principalController,
                      label: 'Principal Amount (₹)',
                      icon: Icons.account_balance_wallet_outlined,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _rateController,
                      label: 'Rate of Interest (%)',
                      icon: Icons.percent,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _timeController,
                      label: 'Time (Years)',
                      icon: Icons.access_time,
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
                      decoration: InputDecoration(
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
              AnimatedOpacity(
                duration: const Duration(seconds: 2),
                // opacity: ,
                opacity: 1,
                child: Card(
                  color: colorScheme.tertiary,
                  elevation: 6,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          'Compound Interest: ₹${_compoundInterest!.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: colorScheme.secondary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Total Amount: ₹${_totalAmount!.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            // color: colorScheme.onSecondary.withOpacity(0.8),
                            color: colorScheme.secondary
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: colorScheme.primary),
        filled: true,
        fillColor: colorScheme.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        labelStyle: TextStyle(color: colorScheme.onSurface),
        hintStyle: TextStyle(color: colorScheme.onSurface.withOpacity(0.6)),
      ),
      onChanged: (_) => _calculateCI(),
    );
  }
}
