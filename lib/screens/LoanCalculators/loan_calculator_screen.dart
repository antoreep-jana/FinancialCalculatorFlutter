import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'loan_calculators_page.dart';
// import 'car_loan_page.dart';
// import 'personal_loan_page.dart';
// import 'student_loan_page.dart';

class LoanCalculatorPage extends StatelessWidget {
  const LoanCalculatorPage({super.key});

  Color _getCardColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    // Dark reddish-black for dark mode, reddish for light mode
    // return brightness == Brightness.dark
    //     ? Colors.purple
    //     : Colors.red.shade700;
    // return Colors.grey;
    // return Colors.black;
    return Colors.deepPurple.shade400.withOpacity(0.14);
  }

  Color _getTextColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? Colors.white : Colors.white;
  }

  Widget _buildCard(BuildContext context, String title, Widget page, IconData icon) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        CupertinoPageRoute(builder: (_) => page),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _getCardColor(context),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black54
                  : Colors.grey.shade400,
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary, size: 28),
            const SizedBox(width: 20),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                color: _getTextColor(context),
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.none
              ),
            ),
            const Spacer(),
            Icon(
              CupertinoIcons.forward,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey.shade300
                  : Colors.grey.shade700,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Loan Calculators',
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black87,
            fontSize: 25
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              _buildCard(
                  context,
                  "EMI Calculator",
                  const LoanCalculatorScreen(),
                  CupertinoIcons.house_fill),
              // _buildCard(context, "Car Loan Calculator", const CarLoanPage(), CupertinoIcons.car_detailed),
              // _buildCard(context, "Personal Loan Calculator", const PersonalLoanPage(), CupertinoIcons.person_crop_circle),
              // _buildCard(context, "Student Loan Calculator", const StudentLoanPage(), CupertinoIcons.book_fill),
            ],
          ),
        ),
      ),
    );
  }
}
