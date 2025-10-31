import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LumpsumSummaryCard extends StatefulWidget {

  final double futureValue;
  final double principal;
  final double rate;
  final double duration;

  const LumpsumSummaryCard({super.key, required this.futureValue, required this.principal, required this.rate, required this.duration});

  @override
  State<LumpsumSummaryCard> createState() => _LumpsumSummaryCardState();
}

class _LumpsumSummaryCardState extends State<LumpsumSummaryCard> {

  String formatWithCommas(double value){
    final formatter = NumberFormat('#,##,###');
    return formatter.format(value);
  }

  //Convert number to Thousands, Lakhs, Crores
  String formatWithUnits(double value){

    if (value >= 10000000){
      return "${(value/10000000).toStringAsFixed(2)} Cr";
    }else if(value >= 100000){
      return "${(value / 100000).toStringAsFixed(2)} L";
    }else if(value >= 1000){
      return "${(value / 1000).toStringAsFixed(2)} K";
    }else{
      return "${value.toStringAsFixed(2)}";
    }

  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12)
      ),
      color: Colors.teal[50],
      margin: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Future Value",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.teal[800]
            ),
          ),
          SizedBox(height: 8,),
          Text(
            "₹${formatWithCommas(widget.futureValue)}",
            style: TextStyle(
              color: Colors.teal[900],
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 8,),
          // Text("")
        ],
      ),
    );
  }
}
