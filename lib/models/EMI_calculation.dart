class EMIData{
  double amount;
  double rate;
  int months;
  double monthlyPayment;
  double totalRepayment;
  double totalInterest;
  String type;

  EMIData({required this.amount, required this.rate, required this.months, required this.monthlyPayment,
    required this.totalRepayment, required this.totalInterest, required this.type});

  Map<String, dynamic> toMap(){
    return {
      'amount' : amount,
      'rate' : rate,
      'months' : months,
      'monthlyPayment' : monthlyPayment,
      'totalRepayment' : totalRepayment,
      'totalInterest' : totalInterest,
      'type' : type
    };
  }

  factory EMIData.fromMap(Map<String, dynamic> map){
    return EMIData(amount: map['amount'], rate: map['rate'], months: map['months'],
            monthlyPayment: map['monthlyPayment'], totalRepayment: map['totalRepayment'],
      totalInterest: map['totalInterest'], type : map['type']
    );
  }
}