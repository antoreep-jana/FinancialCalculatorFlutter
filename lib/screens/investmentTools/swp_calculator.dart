// import 'package:flutter/material.dart';
//
// class SWPCalculator extends StatefulWidget {
//   @override
//   _SWPCalculatorState createState() => _SWPCalculatorState();
// }
//
// class _SWPCalculatorState extends State<SWPCalculator> {
//   final TextEditingController lumpsumController = TextEditingController();
//   final TextEditingController rateController = TextEditingController();
//   final TextEditingController withdrawalController = TextEditingController();
//   final TextEditingController periodController = TextEditingController();
//
//   bool showDetailedResults = false;
//   String selectedCurrency = 'USD'; // Currency selection
//   List<String> currencies = ['USD', 'EUR', 'INR', 'GBP'];
//
//   double lumpsum = 0;
//   double rateOfReturn = 0;
//   double withdrawalAmount = 0;
//   int timePeriodInMonths = 0;
//   double finalRemainingValue = 0;
//   double totalWithdrawn = 0;
//
//   // Method to calculate SWP table values
//   void calculateSWP() {
//     setState(() {
//       lumpsum = double.parse(lumpsumController.text);
//       rateOfReturn = double.parse(rateController.text);
//       withdrawalAmount = double.parse(withdrawalController.text);
//       timePeriodInMonths = int.parse(periodController.text);
//
//       // Calculate the total withdrawn amount
//       totalWithdrawn = withdrawalAmount * timePeriodInMonths;
//
//       // Calculate the final remaining value after all withdrawals
//       finalRemainingValue = lumpsum;
//       double monthlyRate = rateOfReturn / 100 / 12;
//
//       for (int i = 0; i < timePeriodInMonths; i++) {
//         finalRemainingValue =
//             (finalRemainingValue * (1 + monthlyRate)) - withdrawalAmount;
//         if (finalRemainingValue < 0) {
//           finalRemainingValue = 0;
//           break;
//         }
//       }
//     });
//   }
//
//   // Switch to toggle detailed result view
//   void toggleDetailedView() {
//     setState(() {
//       showDetailedResults = !showDetailedResults;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue[50], // Soft Blue background
//       appBar: AppBar(
//         title: Text(
//           'SWP Calculator',
//           style: TextStyle(
//             fontSize: 22,
//             fontWeight: FontWeight.bold,
//             letterSpacing: 1.2,
//             color: Colors.white,
//           ),
//         ),
//         backgroundColor: Colors.blue[900], // Deep blue for the AppBar
//         elevation: 8.0, // Adding shadow for prominence
//         centerTitle: true,
//         actions: [
//           // Currency dropdown or icon button
//           PopupMenuButton<String>(
//             onSelected: (currency) {
//               setState(() {
//                 selectedCurrency = currency;
//               });
//             },
//             icon: Icon(
//               Icons.currency_exchange,
//               color: Colors.white,
//             ),
//             itemBuilder: (BuildContext context) {
//               return currencies.map((String currency) {
//                 return PopupMenuItem<String>(
//                   value: currency,
//                   child: Text(currency),
//                 );
//               }).toList();
//             },
//           ),
//           SizedBox(width: 16), // Space between the buttons
//           IconButton(
//             icon: Icon(
//               Icons.history,
//               color: Colors.white,
//             ),
//             onPressed: () {
//               // Navigate to History page (to be implemented)
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => HistoryPage()),
//               );
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             // Cartoonish Image for the header
//             Container(
//               height: 250,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: NetworkImage(
//                     'https://substack-post-media.s3.amazonaws.com/public/images/c2742335-a7d9-4b7c-9f1b-1354564b3ce0_1792x1024.png',
//                   ),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   // Input Fields
//                   _buildTextField(
//                     controller: lumpsumController,
//                     label: 'Lumpsum Amount',
//                     icon: Icons.money,
//                   ),
//                   _buildTextField(
//                     controller: rateController,
//                     label: 'Rate of Return (%)',
//                     icon: Icons.percent,
//                   ),
//                   _buildTextField(
//                     controller: withdrawalController,
//                     label: 'Monthly Withdrawal Amount',
//                     icon: Icons.account_balance_wallet,
//                   ),
//                   _buildTextField(
//                     controller: periodController,
//                     label: 'Time Period (Months)',
//                     icon: Icons.access_time,
//                   ),
//                   SizedBox(height: 20),
//
//                   // Calculate Button
//                   ElevatedButton(
//                     onPressed: calculateSWP,
//                     child: Text('Calculate SWP'),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue[600], // Light Blue button
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       padding: EdgeInsets.symmetric(vertical: 14),
//                       textStyle: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//
//                   // Display Results
//                   if (withdrawalAmount > 0)
//                     Card(
//                       color: Colors.white, // Clean white card
//                       elevation: 6,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Total Withdrawn Amount: \$${totalWithdrawn.toStringAsFixed(2)}',
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.blue[800], // Dark Blue text
//                               ),
//                             ),
//                             SizedBox(height: 10),
//                             Text(
//                               'Final Remaining Value: \$${finalRemainingValue.toStringAsFixed(2)}',
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.blue[800], // Dark Blue text
//                               ),
//                             ),
//                             SizedBox(height: 10),
//                             // Toggle for detailed view
//                             SwitchListTile(
//                               title: Text(
//                                 'Show Detailed Results',
//                                 style: TextStyle(color: Colors.blue[800]),
//                               ),
//                               value: showDetailedResults,
//                               onChanged: (value) => toggleDetailedView(),
//                             ),
//                             if (showDetailedResults)
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 12.0),
//                                 child: SingleChildScrollView(
//                                   scrollDirection: Axis.horizontal,
//                                   child: DataTable(
//                                     columns: const [
//                                       DataColumn(label: Text('Month')),
//                                       DataColumn(label: Text('Withdrawal')),
//                                       DataColumn(
//                                         label: Text('Remaining Balance'),
//                                       ),
//                                     ],
//                                     rows: List.generate(timePeriodInMonths, (
//                                         index,
//                                         ) {
//                                       // Calculate balance with monthly interest
//                                       double balance = lumpsum;
//                                       double monthlyRate =
//                                           rateOfReturn / 100 / 12;
//
//                                       // Compound the balance and subtract the monthly withdrawal
//                                       for (int i = 0; i <= index; i++) {
//                                         balance =
//                                             (balance * (1 + monthlyRate)) -
//                                                 withdrawalAmount;
//                                       }
//
//                                       // If balance goes negative, set it to zero
//                                       if (balance < 0) {
//                                         balance = 0;
//                                       }
//
//                                       return DataRow(
//                                         cells: [
//                                           DataCell(
//                                             Text((index + 1).toString()),
//                                           ),
//                                           DataCell(
//                                             Text(
//                                               '\$${withdrawalAmount.toStringAsFixed(2)}',
//                                             ),
//                                           ),
//                                           DataCell(
//                                             Text(
//                                               '\$${balance.toStringAsFixed(2)}',
//                                             ),
//                                           ),
//                                         ],
//                                       );
//                                     }),
//                                   ),
//                                 ),
//                               ),
//                           ],
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // Helper method for text fields
//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required IconData icon,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12.0),
//       child: TextField(
//         controller: controller,
//         decoration: InputDecoration(
//           labelText: label,
//           prefixIcon: Icon(icon),
//           filled: true,
//           fillColor: Colors.grey[200], // Light gray background for input
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8),
//             borderSide: BorderSide(color: Colors.blue[400]!, width: 1),
//           ),
//         ),
//         keyboardType: TextInputType.number,
//       ),
//     );
//   }
// }
//
// // History Page (placeholder)
// class HistoryPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('History'),
//         backgroundColor: Colors.blue[900],
//       ),
//       body: Center(
//         child: Text('History Page Content Goes Here'),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

class SWPCalculator extends StatefulWidget {
  @override
  _SWPCalculatorState createState() => _SWPCalculatorState();
}

class _SWPCalculatorState extends State<SWPCalculator>
    with SingleTickerProviderStateMixin {
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

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
  }

  void calculateSWP() {
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

      _animationController.forward(from: 0);
    });
  }

  void toggleDetailedView() {
    setState(() {
      showDetailedResults = !showDetailedResults;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color accentPurple = Colors.purple.shade400;
    final Color accentTeal = Colors.teal.shade400;
    final Color accentIndigo = Colors.indigo.shade400;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('SWP Calculator'),
        backgroundColor: Colors.indigo,
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            onSelected: (currency) {
              setState(() {
                selectedCurrency = currency;
              });
            },
            icon: Icon(Icons.currency_exchange),
            itemBuilder: (BuildContext context) {
              return currencies
                  .map((currency) => PopupMenuItem<String>(
                value: currency,
                child: Text(currency),
              ))
                  .toList();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Input Card
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildTextField(
                        controller: lumpsumController,
                        label: 'Lumpsum Amount',
                        icon: Icons.money,
                        highlightColor: accentPurple),
                    _buildTextField(
                        controller: rateController,
                        label: 'Rate of Return (%)',
                        icon: Icons.percent,
                        highlightColor: accentTeal),
                    _buildTextField(
                        controller: withdrawalController,
                        label: 'Monthly Withdrawal Amount',
                        icon: Icons.account_balance_wallet,
                        highlightColor: accentIndigo),
                    _buildTextField(
                        controller: periodController,
                        label: 'Time Period (Months)',
                        icon: Icons.access_time,
                        highlightColor: accentPurple),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: calculateSWP,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accentTeal,
                        padding:
                        EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Calculate SWP',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            // Results Card
            if (withdrawalAmount > 0)
              FadeTransition(
                opacity: _animationController
                    .drive(Tween(begin: 0.0, end: 1.0)
                    .chain(CurveTween(curve: Curves.easeIn))),
                child: Card(
                  color: Colors.white,
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
                            color: accentPurple),
                        _buildResultRow(
                            label: 'Remaining Value',
                            value: finalRemainingValue,
                            color: accentIndigo),
                        SwitchListTile(
                          title: Text('Show Detailed Results',
                              style: TextStyle(color: accentTeal)),
                          value: showDetailedResults,
                          onChanged: (value) => toggleDetailedView(),
                        ),
                        if (showDetailedResults)
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              headingRowColor: MaterialStateProperty.all(
                                  Colors.grey.shade200),
                              columns: [
                                DataColumn(
                                    label: Text('Month',
                                        style: TextStyle(color: accentPurple))),
                                DataColumn(
                                    label: Text('Withdrawal',
                                        style: TextStyle(color: accentTeal))),
                                DataColumn(
                                    label: Text('Balance',
                                        style: TextStyle(color: accentIndigo))),
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
                                      '${selectedCurrency} ${withdrawalAmount.toStringAsFixed(2)}')),
                                  DataCell(Text(
                                      '${selectedCurrency} ${balance.toStringAsFixed(2)}')),
                                ]);
                              }),
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
    required Color highlightColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        style: TextStyle(color: Colors.black87),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: highlightColor),
          prefixIcon: Icon(icon, color: highlightColor),
          filled: true,
          fillColor: Colors.grey[100],
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: highlightColor, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
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
          Text('${selectedCurrency} ${value.toStringAsFixed(2)}',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }
}
