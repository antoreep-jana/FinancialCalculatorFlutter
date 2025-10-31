import 'package:intl/intl.dart';
import 'dart:math';

// Format a number with commas
String formatWithCommas(double Value){
  final formatter = NumberFormat("#,##,###");
  return formatter.format(Value);
}

String formatWithUnits(double Value){
  if (Value >= 10000000){
    return "${(Value / 1000000).toStringAsFixed(2)} Cr";
  }else if(Value >= 100000){
    return "${(Value / 100000).toStringAsFixed(2)} L";
  }else if(Value >= 1000){
    return "${(Value / 1000).toStringAsFixed(2)} K";
  }else{
    return "${Value.toStringAsFixed(2)}";
  }
}

double calculateFutureValue(double principal, double rate, double time){
  return principal * pow(1 + rate / 100 , time).toDouble();
}

Map<String, double> calculateSIP(double amount, double rate, double time){
    // if (amount == null || rate == null || time == null) return;

    if (amount <= 0 || rate <= 0 || time <= 0){
      throw ArgumentError("Amount, Error and Time must be positive values");
    }

    final double monthlyRate = rate / 12 / 100;

    final int months = (time * 12).toInt();

    double fv = amount * ((pow(1 + monthlyRate, months) - 1)/monthlyRate);

    double invested = amount * months;

    double returns = fv - invested;

    return {"fv" : fv, "invested" : invested, "returns" : returns};
  }