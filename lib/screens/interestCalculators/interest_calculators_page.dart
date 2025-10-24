import 'package:flutter/material.dart';
import 'simple_interest_screen.dart';
import 'compound_interest_screen.dart';

class InterestCalculatorsPage extends StatelessWidget {
  const InterestCalculatorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final calculators = [
      {
        'title': 'Simple Interest Calculator',
        'icon': Icons.calculate_outlined,
        'screen': const SimpleInterestScreen(),
      },
      {
        'title': 'Compound Interest Calculator',
        'icon': Icons.trending_up_outlined,
        'screen': const CompoundInterestScreen(),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4F46E5),
        title: const Text(
          "Interest Calculators",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFF9FAFB),
      body: ListView.separated(
        itemCount: calculators.length,
        padding: const EdgeInsets.all(16),
        separatorBuilder: (_, __) => const SizedBox(height: 14),
        itemBuilder: (context, index) {
          final item = calculators[index];
          return InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => item['screen'] as Widget),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor:
                    const Color(0xFF4F46E5).withOpacity(0.1),
                    child: Icon(item['icon'] as IconData,
                        color: const Color(0xFF4F46E5), size: 26),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      item['title'] as String,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios_rounded,
                      color: Colors.grey, size: 16),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
