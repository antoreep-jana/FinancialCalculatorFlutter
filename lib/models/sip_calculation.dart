class SIPCalculationData{
  double investment;
  double time;
  double expected_returns;

  double futureValue;
  double totalInvested;
  double estimatedReturns;
  String type;
  double? investment_frequency;

  SIPCalculationData({required this.investment,
    required this.time,
    required this.expected_returns,

    required this.futureValue,
    required this.totalInvested,
    required this.estimatedReturns,
    required this.type,
    this.investment_frequency});


  Map<String, dynamic> toMap(){
    return {
      "investment" : investment,
      "time" : time,
      "expected_returns" : expected_returns,

      "futureValue" : futureValue,
      "totalInvested" : totalInvested,
      "estimatedReturns" : estimatedReturns,
      "type": "SIP"
      //investment_frequency? "investment_frequency" : investment_frequency : 0,
    };
  }

  factory SIPCalculationData.fromMap(Map<String, dynamic> map){
    return SIPCalculationData(
        investment: map['investment'],
        time: map['time'],
        expected_returns: map['expected_returns'],
        futureValue: map['futureValue'],
        totalInvested: map['totalInvested'],
        estimatedReturns: map['estimatedReturns'],
        type : map['type']
    );
  }

}