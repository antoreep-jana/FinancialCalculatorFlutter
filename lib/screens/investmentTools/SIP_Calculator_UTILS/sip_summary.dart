import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class SIPSummaryCard extends StatefulWidget {

  final double totalInvested;
  final double estimatedReturns;
  final double futureValue;

  const SIPSummaryCard({super.key,
  required this.totalInvested,
    required this.estimatedReturns,
    required this.futureValue
  });

  @override
  State<SIPSummaryCard> createState() => _SIPSummaryCardState();
}

class _SIPSummaryCardState extends State<SIPSummaryCard> {

  bool isExact = false;

  // TODO: Format currency with commas and two decimal points

  // Format large numbers with suffixes (K,L,M)
  String formatLargeNumber(double value){
    if(value >= 10000000){
      return "${(value / 10000000).toStringAsFixed(2)}Cr";
    }else if(value >= 100000){
      return "${(value / 100000).toStringAsFixed(2)}L";
    }else if (value >= 1000){
      return "${(value / 1000).toStringAsFixed(2)}K";
    }else{
      return value.toStringAsFixed(2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.teal.shade50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16)
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("SIP Summary",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal
                ),
                ),
                Row(
                  children: [

                    // TODO : Add a good animated Switch effect. (lift weight not heavy).
                   isExact?
                    const Text(
                      "Exact",
                      style: TextStyle(color: Colors.teal, fontSize: 12),
                    ):const Text(
                     "Approx",
                     style: TextStyle(color: Colors.teal, fontSize: 12),
                   ),
                    const SizedBox(width: 4,),
                    Switch(value: isExact, onChanged: (bool newValue){
                      setState(() {
                        isExact = newValue;
                      });
                    }),
                    // const Text(
                    //   "Approx",
                    //   style: TextStyle(color: Colors.teal),
                    // )
                  ],
                ),

              ],
            ),

            const Divider(),
            ListTile(
              leading: const Icon(Icons.account_balance_wallet, color: Colors.teal),
              title: const Text("Total Invested"),
              trailing: Text("₹${isExact? widget.totalInvested.toStringAsFixed(2) : formatLargeNumber(widget.totalInvested)}"),
            ),
            ListTile(
              leading: const Icon(Icons.trending_up, color: Colors.green,),
              title: const Text("Estimated Returns"),
              trailing: Text("₹${isExact? widget.estimatedReturns.toStringAsFixed(2) : formatLargeNumber(widget.estimatedReturns)}")
            ),
            ListTile(
              leading: const Icon(Icons.savings, color: Colors.blue),
              title: const Text("Future Value"),
              trailing: Text("₹${isExact? widget.futureValue.toStringAsFixed(2) : formatLargeNumber(widget.futureValue)}")
            )
          ],
        ),
      ),
    );
  }
}
