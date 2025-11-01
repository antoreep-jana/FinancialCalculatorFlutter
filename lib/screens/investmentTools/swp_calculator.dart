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
  String selectedCurrency = 'USD'; // Currency selection
  List<String> currencies = ['USD', 'EUR', 'INR', 'GBP'];

  double lumpsum = 0;
  double rateOfReturn = 0;
  double withdrawalAmount = 0;
  int timePeriodInMonths = 0;
  double finalRemainingValue = 0;
  double totalWithdrawn = 0;

  // Method to calculate SWP table values
  void calculateSWP() {
    setState(() {
      lumpsum = double.parse(lumpsumController.text);
      rateOfReturn = double.parse(rateController.text);
      withdrawalAmount = double.parse(withdrawalController.text);
      timePeriodInMonths = int.parse(periodController.text);

      // Calculate the total withdrawn amount
      totalWithdrawn = withdrawalAmount * timePeriodInMonths;

      // Calculate the final remaining value after all withdrawals
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
  }

  // Switch to toggle detailed result view
  void toggleDetailedView() {
    setState(() {
      showDetailedResults = !showDetailedResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50], // Soft Blue background
      appBar: AppBar(
        title: Text(
          'SWP Calculator',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue[900], // Deep blue for the AppBar
        elevation: 8.0, // Adding shadow for prominence
        centerTitle: true,
        actions: [
          // Currency dropdown or icon button
          PopupMenuButton<String>(
            onSelected: (currency) {
              setState(() {
                selectedCurrency = currency;
              });
            },
            icon: Icon(
              Icons.currency_exchange,
              color: Colors.white,
            ),
            itemBuilder: (BuildContext context) {
              return currencies.map((String currency) {
                return PopupMenuItem<String>(
                  value: currency,
                  child: Text(currency),
                );
              }).toList();
            },
          ),
          SizedBox(width: 16), // Space between the buttons
          IconButton(
            icon: Icon(
              Icons.history,
              color: Colors.white,
            ),
            onPressed: () {
              // Navigate to History page (to be implemented)
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HistoryPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Cartoonish Image for the header
            Container(
              height: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://substack-post-media.s3.amazonaws.com/public/images/c2742335-a7d9-4b7c-9f1b-1354564b3ce0_1792x1024.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Input Fields
                  _buildTextField(
                    controller: lumpsumController,
                    label: 'Lumpsum Amount',
                    icon: Icons.money,
                  ),
                  _buildTextField(
                    controller: rateController,
                    label: 'Rate of Return (%)',
                    icon: Icons.percent,
                  ),
                  _buildTextField(
                    controller: withdrawalController,
                    label: 'Monthly Withdrawal Amount',
                    icon: Icons.account_balance_wallet,
                  ),
                  _buildTextField(
                    controller: periodController,
                    label: 'Time Period (Months)',
                    icon: Icons.access_time,
                  ),
                  SizedBox(height: 20),

                  // Calculate Button
                  ElevatedButton(
                    onPressed: calculateSWP,
                    child: Text('Calculate SWP'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[600], // Light Blue button
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14),
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Display Results
                  if (withdrawalAmount > 0)
                    Card(
                      color: Colors.white, // Clean white card
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Withdrawn Amount: \$${totalWithdrawn.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[800], // Dark Blue text
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Final Remaining Value: \$${finalRemainingValue.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[800], // Dark Blue text
                              ),
                            ),
                            SizedBox(height: 10),
                            // Toggle for detailed view
                            SwitchListTile(
                              title: Text(
                                'Show Detailed Results',
                                style: TextStyle(color: Colors.blue[800]),
                              ),
                              value: showDetailedResults,
                              onChanged: (value) => toggleDetailedView(),
                            ),
                            if (showDetailedResults)
                              Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DataTable(
                                    columns: const [
                                      DataColumn(label: Text('Month')),
                                      DataColumn(label: Text('Withdrawal')),
                                      DataColumn(
                                        label: Text('Remaining Balance'),
                                      ),
                                    ],
                                    rows: List.generate(timePeriodInMonths, (
                                        index,
                                        ) {
                                      // Calculate balance with monthly interest
                                      double balance = lumpsum;
                                      double monthlyRate =
                                          rateOfReturn / 100 / 12;

                                      // Compound the balance and subtract the monthly withdrawal
                                      for (int i = 0; i <= index; i++) {
                                        balance =
                                            (balance * (1 + monthlyRate)) -
                                                withdrawalAmount;
                                      }

                                      // If balance goes negative, set it to zero
                                      if (balance < 0) {
                                        balance = 0;
                                      }

                                      return DataRow(
                                        cells: [
                                          DataCell(
                                            Text((index + 1).toString()),
                                          ),
                                          DataCell(
                                            Text(
                                              '\$${withdrawalAmount.toStringAsFixed(2)}',
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              '\$${balance.toStringAsFixed(2)}',
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method for text fields
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          filled: true,
          fillColor: Colors.grey[200], // Light gray background for input
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.blue[400]!, width: 1),
          ),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

// History Page (placeholder)
class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        backgroundColor: Colors.blue[900],
      ),
      body: Center(
        child: Text('History Page Content Goes Here'),
      ),
    );
  }
}
