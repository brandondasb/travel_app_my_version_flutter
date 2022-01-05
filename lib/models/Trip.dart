class Trip {
  String title;
  DateTime startDate;
  DateTime endDate;
  double budget;
  String travelType;

  Trip(this.title, this.startDate, this.endDate, this.budget, this.travelType);

  //convert class to json for firebase
  Map<String, dynamic> toJson() => {
        'title': title,
        'startDate': startDate,
        'endDate': endDate,
        'bugdet': budget,
        "travelType": travelType
      };
}
