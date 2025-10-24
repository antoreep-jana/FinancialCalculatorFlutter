class InterestData{
  //int? id;
  double principal;
  double rate;
  double time;
  double result;
  double amount;
  String type; // SI/CI
  String? compoundedFrequency;
  //String createdAt;


  InterestData({
    //this.id,
  required this.principal,
    required this.rate,
    required this.time,
    required this.result,
    required this.amount,
    required this.type,
    this.compoundedFrequency,
    //required this.createdAt
  });

  Map<String, dynamic> toMap(){
    return {
      //"id" : id,
      "principal" : principal,
      "rate" : rate,
      "time" : time,
      "result" : result,
      "amount" : amount,
      "type" : type,
     // "compounded_frequency" : compoundedFrequency,
      //"created_at" : createdAt
    };
  }

  factory InterestData.fromMap(Map<String, dynamic> map){
    return InterestData( //id : map['id'],
        principal: map['principal'],
        rate: map['rate'],
        time: map['time'],
        result: map['result'],
        amount: map['amount'],
        type: map['type'],
       // createdAt: map['createdAt']
    );
  }

}