// import 'package:financialcalc/screens/history/history_page.dart';
// import 'package:financialcalc/screens/investmentTools/investment_tools_page.dart';

import 'package:financial_calculator/screens/settings/backup_sync.dart';
import 'package:financial_calculator/screens/settings/settings.dart';
import 'package:flutter/material.dart';
import 'FeeTaxAnalyzers/fee_tax_analyzer_page.dart';
import 'LoanCalculators/loan_calculators_page.dart';
import 'history/history_page.dart';
import 'interestCalculators/interest_calculators_page.dart';
import 'investmentTools/investment_tools_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Pages for BottomNavigationBar
  final List<Widget> _pages = [
    const HomeTab(), // We'll define HomeTab separately
    const HistoryTab(), // Placeholder for History
    const ProfileTab(), // Placeholder for Profile
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 80,
        backgroundColor: const Color(0xFF4F46E5),
        centerTitle: true,
        title: const Text(
          "Financial Calculator",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color(0xFF4F46E5),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// Home Tab (your existing home content)
class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {
        'title': 'Interest Calculators',
        'icon': Icons.percent_rounded,
        'subItems': ['Simple Interest', 'Compound Interest'],
        'page': InterestCalculatorsPage()
      },
      {
        'title': 'Loan Calculators',
        'icon': Icons.account_balance_rounded,
        'subItems': ['EMI Calculator', 'Amortization Table'],
        'page': LoanCalculatorsPage()
      },
      {
        'title': 'Investment Tools',
        'icon': Icons.trending_up_rounded,
        'subItems': ['SIP Calculator', 'Lumpsum Calculator','Retirement Planner', "SWP Calculator"],
        'page': InvestmentToolsPage()
      },
      {
        'title': 'Fee & Tax Analyzers',
        'icon': Icons.receipt_long_rounded,
        'subItems': ['Hidden Fee Analyzer', 'Credit Card Fee'],
        'page': FeeTaxAnalyzersPage()
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.separated(
        itemCount: categories.length,
        separatorBuilder: (context, _) => const SizedBox(height: 18),
        itemBuilder: (context, index) {
          final category = categories[index];
          final subItems = category['subItems'] as List<String>;

          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => category['page']),
              );
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.white.withOpacity(0.95),
                  ],
                ),
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.12),
                    blurRadius: 12,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor:
                        const Color(0xFF4F46E5).withOpacity(0.12),
                        child: Icon(
                          category['icon'] as IconData,
                          color: const Color(0xFF4F46E5),
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 18),
                      Expanded(
                        child: Text(
                          category['title'] as String,
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.grey,
                        size: 18,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: subItems.map((item) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4F46E5).withOpacity(0.08),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Text(
                          item,
                          style: const TextStyle(
                            color: Color(0xFF1F2937),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Placeholder tabs
class HistoryTab extends StatelessWidget {
  const HistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    // return const Center(
    //   child: Text(
    //     'History Page',
    //     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    //   ),
    // );

    return HistoryPage();
  }
}

// class ProfileTab extends StatelessWidget {
//   const ProfileTab({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text(
//         'Profile Page',
//         style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//       ),
//     );
//   }
// }

// WORKS
// class ProfileTab extends StatelessWidget {
//   const ProfileTab({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return SettingsPage();
//   }
// }

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});



  @override
  Widget build(BuildContext context) {
    bool syncValue = true;

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Profile Settings'),
      // ),
      body: SingleChildScrollView(  // Ensuring the content is scrollable
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile section
            Text(
              "Profile",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),

            // Settings section title
            Text(
              "Settings",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 8),

            // Embedding the SettingsPage widget
             SettingsPage(),  // Embed the settings page

            // Backup Page.
            const SizedBox(height: 8,),
            // Settings section title
            Text(
              "Backup & Syncing",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
            // Backup & Syncing Options

            BackupAndSync()
          ],
        ),
      ),
    );
  }
}