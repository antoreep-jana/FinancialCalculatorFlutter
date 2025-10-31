// import 'package:financialcalc/database/db_helper.dart';
// import 'package:financialcalc/screens/history/history_page.dart';
import 'package:flutter/material.dart';
import '../../database/db_helper.dart';
import '../../models/calculation.dart';
import '../history/history_page.dart';

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

  @override
  void initState() {
    super.initState();
    _principalController.addListener(_onTextChanged);
    _rateController.addListener(_onTextChanged);
    _timeController.addListener(_onTextChanged);
  }

  void _onTextChanged() async {
    final principalText = _principalController.text;
    final rateText = _rateController.text;
    final timeText = _timeController.text;

    if (principalText.isNotEmpty &&
        rateText.isNotEmpty &&
        timeText.isNotEmpty) {
      final principal = double.tryParse(principalText);
      final rate = double.tryParse(rateText);
      final time = double.tryParse(timeText);

      if (principal != null && rate != null && time != null) {
        final si = (principal * rate * time) / 100;
        final amount = principal + si;

        setState(() {
          _simpleInterest = si;
          _totalAmount = amount;
        });

        await DBHelper.instance.insertData(
          InterestData.fromMap({
            'principal': principal,
            'rate': rate,
            'time': time,
            'result': si,
            'amount': amount,
            "type": "SI"
          }),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f8fc),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: const Text(
          "Simple Interest",
          style: TextStyle(
              color: Color(0xff1a1a1a),
              fontWeight: FontWeight.bold,
              fontSize: 22),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history, color: Color(0xff1a1a1a)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => HistoryPage()),
              );
            },
          )
        ],
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Input Card
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 5,
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  children: [
                    _buildTextField(
                        controller: _principalController,
                        label: "Principal Amount",
                        hint: "Enter principal in ₹",
                        icon: Icons.account_balance_wallet_rounded),
                    const SizedBox(height: 20),
                    _buildTextField(
                        controller: _rateController,
                        label: "Rate of Interest",
                        hint: "Enter rate (%)",
                        icon: Icons.percent_rounded),
                    const SizedBox(height: 20),
                    _buildTextField(
                        controller: _timeController,
                        label: "Time Period",
                        hint: "Enter time in years",
                        icon: Icons.schedule_rounded),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Result Card
            _simpleInterest != null
                ? Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                    colors: [Color(0xff42a5f5), Color(0xff1976d2)]),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4))
                ],
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Text(
                    "Simple Interest",
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "₹${_simpleInterest!.toStringAsFixed(2)}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Total Amount",
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "₹${_totalAmount!.toStringAsFixed(2)}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
                : Center(
              child: Column(
                children: const [
                  Icon(Icons.show_chart_rounded,
                      size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    "Enter values to calculate",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      {required TextEditingController controller,
        required String label,
        required String hint,
        required IconData icon}) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: const Color(0xff1976d2)),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      ),
    );
  }
}
