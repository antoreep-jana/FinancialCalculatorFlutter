class SWPCalculationData{
  double lumpsum;
  double rate;
  double monthly_withdrawl;
  int time;
  double totalWithdrawn;
  double remaining;
  String type;

  SWPCalculationData({required this.lumpsum, required this.rate, required this.monthly_withdrawl, required this.time, required this.totalWithdrawn, required this.remaining, required this.type});


  Map<String, dynamic> toMap(){
    return {
      'lumpsum' : lumpsum,
      'rate' : rate,
      'monthly_withdrawl' : monthly_withdrawl,
      'time' : time,

      'totalWithdrawn' : totalWithdrawn,
      'remaining' : remaining,
      'type' : type

    };
  }

  factory SWPCalculationData.fromMap(Map<String, dynamic> map){
    return SWPCalculationData(lumpsum: map['lumpsum'],
        rate: map['rate'],
        monthly_withdrawl: map['monthly_withdrawl'],
        time: map['time'],
        totalWithdrawn: map['totalWithdrawn'],
        remaining: map['remaining'],
        type : map['type']);
  }
}

