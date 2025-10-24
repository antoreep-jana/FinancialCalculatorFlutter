import 'package:financialcalc/screens/investmentTools/investment_tools_page.dart';
import 'package:flutter/material.dart';
import 'FeeTaxAnalyzers/fee_tax_analyzer_page.dart';
import 'LoanCalculators/loan_calculators_page.dart';
import 'interestCalculators/interest_calculators_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {
        'title': 'Interest Calculators',
        'icon': Icons.percent_rounded,
        'subItems': ['Simple Interest', 'Compound Interest'],
        'page' : InterestCalculatorsPage()
      },
      {
        'title': 'Loan Calculators',
        'icon': Icons.account_balance_rounded,
        'subItems': ['EMI Calculator', 'Amortization Table'],
        'page' : LoanCalculatorsPage()
      },
      {
        'title': 'Investment Tools',
        'icon': Icons.trending_up_rounded,
        'subItems': ['SIP Calculator', 'Retirement Planner'],
        "page" : InvestmentToolsPage()
      },
      {
        'title': 'Fee & Tax Analyzers',
        'icon': Icons.receipt_long_rounded,
        'subItems': ['Hidden Fee Analyzer', 'Credit Card Fee'],
        'page' : FeeTaxAnalyzersPage()
      },
    ];

    return Scaffold(
      backgroundColor : const Color(0xFFF9FAFB),
      appBar : AppBar(
        elevation : 0,
        toolbarHeight : 80,
        backgroundColor : const Color(0xFF4F46E5),
        centerTitle : true,
        title : const Text(
          "Financial Calculator",
          style : TextStyle(
            fontSize : 22,
            fontWeight : FontWeight.bold,
            color : Colors.white,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          itemCount: categories.length,
          separatorBuilder: (context, _) => const SizedBox(height: 18),
          itemBuilder: (context, index) {
            final category = categories[index];
            final subItems = category['subItems'] as List<String>;

            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {


                  // TODO: navigate to category page
                  // if (category['title'] == "Interest Calculators"){
                  //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => InterestCalculatorsPage()));
                  // }
                  // if(category['title'] == "Investment Tools"){
                  //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => InvestmentToolsPage()));
                  // }

                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => category['page']));

                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 18.0, horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 26,
                            backgroundColor:
                            const Color(0xFF4F46E5).withOpacity(0.1),
                            child: Icon(
                              category['icon'] as IconData,
                              color: const Color(0xFF4F46E5),
                              size: 26,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              category['title'] as String,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1F2937),
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.grey,
                            size: 16,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: subItems.map((item) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color:
                              const Color(0xFF4F46E5).withOpacity(0.07),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              item,
                              style: const TextStyle(
                                color: Color(0xFF1F2937),
                                fontSize: 13.5,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
