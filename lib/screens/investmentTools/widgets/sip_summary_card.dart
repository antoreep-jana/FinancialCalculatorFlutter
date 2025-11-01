import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  String currencySymbol = "₹";  // Default to Rupee sign

  @override
  void initState(){
    super.initState();
    _loadCurrencySymbol();
  }

  // Load Currency symbol from shared preferences
  _loadCurrencySymbol() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      currencySymbol = prefs.getString("currencySymbol") ?? "₹";  // Default to Rupee sign"
    });
  }

  // TODO: Format currency with commas and two decimal points

  // Format large numbers with suffixes (K,L,M)
  String formatLargeNumber(double value){
    // format large numbers with suffixes K, M, B

    // Check if the currency system is INR
    if (currencySymbol == "₹") {
      if (value >= 10000000) {
        return "${(value / 10000000).toStringAsFixed(1)}Cr"; // Millions
      } else if (value >= 100000) {
        return "${(value / 100000).toStringAsFixed(1)}L"; // Lakhs
      } else if (value >= 1000) {
        return "${(value / 1000).toStringAsFixed(1)}K"; // Thousands
      } else {
        return value.toStringAsFixed(2);
      }
    }
    // Else the american system of currency
    else{
      if(value >= 1000000000){
        return "${(value / 1000000000).toStringAsFixed(2)}B"; // Billions
      }else if (value >= 1000000){
        return "${(value / 1000000).toStringAsFixed(2)}M"; // Millions
      }else if (value >= 1000){
        return "${(value / 1000).toStringAsFixed(2)}K"; // Thousands
      }else{
        return value.toStringAsFixed(2);
      }
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
                   // isExact?
                    const Text(
                      "Exact",
                      style: TextStyle(color: Colors.teal, fontSize: 12),
                    )
                   //      :const Text(
                   //   "Approx",
                   //   style: TextStyle(color: Colors.teal, fontSize: 12),
                   // ),
                    ,const SizedBox(width: 4,),
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
              // trailing: Text("₹${isExact? widget.totalInvested.toStringAsFixed(2) : formatLargeNumber(widget.totalInvested)}"),
              trailing: Text("${currencySymbol}${isExact? widget.totalInvested.toStringAsFixed(2) : formatLargeNumber(widget.totalInvested)}"),
            ),
            ListTile(
              leading: const Icon(Icons.trending_up, color: Colors.green,),
              title: const Text("Estimated Returns"),
              trailing: Text("${currencySymbol}${isExact? widget.estimatedReturns.toStringAsFixed(2) : formatLargeNumber(widget.estimatedReturns)}")
            ),
            ListTile(
              leading: const Icon(Icons.savings, color: Colors.blue),
              title: const Text("Future Value"),
              trailing: Text("${currencySymbol}${isExact? widget.futureValue.toStringAsFixed(2) : formatLargeNumber(widget.futureValue)}")
            )
          ],
        ),
      ),
    );
  }
}
