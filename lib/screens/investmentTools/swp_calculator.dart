import 'package:financial_calculator/database/db_helper.dart';
import 'package:financial_calculator/models/swp_calculation.dart';
import 'package:flutter/material.dart';

class SWPCalculator extends StatefulWidget {
  @override
  _SWPCalculatorState createState() => _SWPCalculatorState();
}

class _SWPCalculatorState extends State<SWPCalculator> {
  final TextEditingController lumpsumController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController withdrawalController = TextEditingController();
  final TextEditingController periodController = TextEditingController();

  bool showDetailedResults = false;
  String selectedCurrency = 'USD';
  List<String> currencies = ['USD', 'EUR', 'INR', 'GBP'];

  double lumpsum = 0;
  double rateOfReturn = 0;
  double withdrawalAmount = 0;
  int timePeriodInMonths = 0;
  double finalRemainingValue = 0;
  double totalWithdrawn = 0;

  void calculateSWP() async{
    setState(() {
      lumpsum = double.tryParse(lumpsumController.text) ?? 0;
      rateOfReturn = double.tryParse(rateController.text) ?? 0;
      withdrawalAmount = double.tryParse(withdrawalController.text) ?? 0;
      timePeriodInMonths = int.tryParse(periodController.text) ?? 0;

      totalWithdrawn = withdrawalAmount * timePeriodInMonths;

      finalRemainingValue = lumpsum;
      double monthlyRate = rateOfReturn / 100 / 12;

      for (int i = 0; i < timePeriodInMonths; i++) {
        finalRemainingValue =
            (finalRemainingValue * (1 + monthlyRate)) - withdrawalAmount;
        if (finalRemainingValue < 0) {
          finalRemainingValue = 0;
          break;
        }
      }
    });

    print("VALUES : $lumpsum, $rateOfReturn, $withdrawalAmount, $timePeriodInMonths, $totalWithdrawn, $finalRemainingValue");

    
    
    try {
      await DBHelper.instance.insertDataSWP(
          SWPCalculationData.fromMap({
        'lumpsum' : lumpsum,
        'rate' : rateOfReturn,
        'monthly_withdrawl' : withdrawalAmount,
        'time' : timePeriodInMonths,
        'totalWithdrawn' : totalWithdrawn,
        'remaining' : finalRemainingValue,
        'type' : 'SWP'
      
      }));

      print("Insertion successful");
    } on Exception catch (e) {
      print("Insert failed : $e");
    }


  }

  void toggleDetailedView() {
    setState(() {
      showDetailedResults = !showDetailedResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final secondaryColor = theme.colorScheme.secondary;
    final surfaceColor = theme.colorScheme.surface;
    final onSurface = theme.colorScheme.onSurface;

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        title: Text('SWP Calculator'),
        backgroundColor: surfaceColor,
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            onSelected: (currency) {
              setState(() {
                selectedCurrency = currency;
              });
            },
            icon: Icon(Icons.currency_exchange),
            itemBuilder: (context) => currencies
                .map((currency) => PopupMenuItem(
              value: currency,
              child: Text(currency),
            ))
                .toList(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Input Card
            Card(
              color: surfaceColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildTextField(
                      controller: lumpsumController,
                      label: 'Lumpsum Amount',
                      icon: Icons.money,
                      theme: Theme.of(context),
                    ),
                    _buildTextField(
                      controller: rateController,
                      label: 'Rate of Return (%)',
                      icon: Icons.percent,
                      theme: Theme.of(context),
                    ),
                    _buildTextField(
                      controller: withdrawalController,
                      label: 'Monthly Withdrawal Amount',
                      icon: Icons.account_balance_wallet,
                      theme: Theme.of(context),
                    ),
                    _buildTextField(
                      controller: periodController,
                      label: 'Time Period (Months)',
                      icon: Icons.access_time,
                      theme: Theme.of(context),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: calculateSWP,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Calculate SWP',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            SizedBox(height: 24),
            // Animated Results Card
            AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset(0, 0.1),
                      end: Offset(0, 0),
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
              child: withdrawalAmount > 0
                  ? Card(
                key: ValueKey(totalWithdrawn),
                color: surfaceColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildResultRow(
                          label: 'Total Withdrawn',
                          value: totalWithdrawn,
                          color: primaryColor),
                      _buildResultRow(
                          label: 'Remaining Value',
                          value: finalRemainingValue,
                          color: secondaryColor),
                      SwitchListTile(
                        title: Text('Show Detailed Results',
                            style: TextStyle(color: onSurface)),
                        value: showDetailedResults,
                        onChanged: (value) => toggleDetailedView(),
                      ),
                      if (showDetailedResults)
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            headingRowColor: MaterialStateProperty.all(
                                theme.colorScheme.background),
                            columns: [
                              DataColumn(
                                  label: Text('Month',
                                      style:
                                      TextStyle(color: primaryColor))),
                              DataColumn(
                                  label: Text('Withdrawal',
                                      style:
                                      TextStyle(color: secondaryColor))),
                              DataColumn(
                                  label: Text('Balance',
                                      style: TextStyle(color: onSurface))),
                            ],
                            rows: List.generate(timePeriodInMonths, (index) {
                              double balance = lumpsum;
                              double monthlyRate = rateOfReturn / 100 / 12;
                              for (int i = 0; i <= index; i++) {
                                balance =
                                    (balance * (1 + monthlyRate)) -
                                        withdrawalAmount;
                                if (balance < 0) balance = 0;
                              }
                              return DataRow(cells: [
                                DataCell(Text('${index + 1}')),
                                DataCell(Text(
                                    '$selectedCurrency ${withdrawalAmount.toStringAsFixed(2)}')),
                                DataCell(Text(
                                    '$selectedCurrency ${balance.toStringAsFixed(2)}')),
                              ]);
                            }),
                          ),
                        ),
                    ],
                  ),
                ),
              )
                  : SizedBox.shrink(),
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
    required ThemeData theme,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        style: TextStyle(color: Colors.white), // text input color
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white), // label text color
          prefixIcon: Icon(icon, color: Colors.white),
          filled: true,
          fillColor: theme.colorScheme.tertiary, // background
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white54, width: 1),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }


  Widget _buildResultRow(
      {required String label, required double value, required Color color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: color)),
          Text('$selectedCurrency ${value.toStringAsFixed(2)}',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }
}
