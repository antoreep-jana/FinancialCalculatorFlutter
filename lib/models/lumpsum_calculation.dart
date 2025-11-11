class LumpsumData{

  double investment;
  double returns;
  double duration;

  double futureValue;
  String type;

  LumpsumData({required this.investment, required this.returns, required this.duration, required this.futureValue, required this.type});


  Map<String, dynamic> toMap(){
      return {
        'investment' : investment,
        'returns' : returns,
        'duration' : duration,
        'futureValue' : futureValue,
        'type' : type
      };
  }

  factory LumpsumData.fromMap(Map<String, dynamic> map){
    return LumpsumData(investment: map['investment'], returns: map['returns'], duration: map['duration'], type : map['type'], futureValue: map['futureValue'] );
  }

}