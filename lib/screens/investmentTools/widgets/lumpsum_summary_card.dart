// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// class LumpsumSummaryCard extends StatefulWidget {
//
//   final double futureValue;
//   // final double principal;
//   // final double rate;
//   // final double duration;
//
//   const LumpsumSummaryCard({super.key, required this.futureValue,});// required this.principal, required this.rate, required this.duration});
//
//   @override
//   State<LumpsumSummaryCard> createState() => _LumpsumSummaryCardState();
// }
//
// class _LumpsumSummaryCardState extends State<LumpsumSummaryCard> {
//
//   String formatWithCommas(double value){
//     final formatter = NumberFormat('#,##,###');
//     return formatter.format(value);
//   }
//
//   //Convert number to Thousands, Lakhs, Crores
//   String formatWithUnits(double value){
//
//     if (value >= 10000000){
//       return "${(value/10000000).toStringAsFixed(2)} Cr";
//     }else if(value >= 100000){
//       return "${(value / 100000).toStringAsFixed(2)} L";
//     }else if(value >= 1000){
//       return "${(value / 1000).toStringAsFixed(2)} K";
//     }else{
//       return "${value.toStringAsFixed(2)}";
//     }
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//
//       elevation: 6,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16)
//       ),
//       color: Colors.teal[50],
//       margin: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
//       child: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Future Value",
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.teal[800]
//               ),
//             ),
//             SizedBox(height: 8,),
//             Text(
//               "₹${formatWithUnits(widget.futureValue)}",
//               style: TextStyle(
//                 color: Colors.teal[900],
//                 fontWeight: FontWeight.bold
//               ),
//             ),
//             SizedBox(height: 8,),
//             // Text("")
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LumpsumSummaryCard extends StatefulWidget {
  final double futureValue;

  const LumpsumSummaryCard({super.key, required this.futureValue});

  @override
  State<LumpsumSummaryCard> createState() => _LumpsumSummaryCardState();
}

class _LumpsumSummaryCardState extends State<LumpsumSummaryCard> {

  String formatWithUnits(double value) {
    if (value >= 10000000) {
      return "${(value / 10000000).toStringAsFixed(2)} Cr";
    } else if (value >= 100000) {
      return "${(value / 100000).toStringAsFixed(2)} L";
    } else if (value >= 1000) {
      return "${(value / 1000).toStringAsFixed(2)} K";
    } else {
      return "${value.toStringAsFixed(2)}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [Colors.teal.shade50, Colors.teal.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.savings, color: Colors.teal.shade800, size: 28),
                SizedBox(width: 10),
                Text(
                  "Future Value",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal.shade800,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              "₹${formatWithUnits(widget.futureValue)}",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade900,
              ),
            ),
            SizedBox(height: 8),
            Divider(color: Colors.teal.shade200, thickness: 1),
            SizedBox(height: 8),
            Text(
              "This is the estimated amount you will receive at the end of the investment period.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.teal.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
