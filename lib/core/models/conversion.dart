class Conversion {
  String date;
  String time;
  String conversionFrom;
  String conversionTo;
  Conversion(
      {required this.date,
      required this.time,
      required this.conversionFrom,
      required this.conversionTo});
  factory Conversion.fromJson(Map<String, dynamic> json) => Conversion(
        date: json["date"],
        time: json["time"],
        conversionFrom: json["conversionFrom"],
        conversionTo: json["conversionTo"],
      );
  Map<String, dynamic> toJson() => {
        "date": date,
        "time": time,
        "conversionFrom": conversionFrom,
        "conversionTo": conversionTo,
      };
}
