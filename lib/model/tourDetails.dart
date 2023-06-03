class tourDetails {
  String? idTourDetails;
  String? idTour;
  String? placeTour;
  String? timeStart;
  int? startDay;
  int? startMonth;
  int? startYear;
  int? dayEnd;
  String? imageTourDetails;
  String? description;
  String? hotel;

  tourDetails(
      {this.idTourDetails = '',
      required this.idTour,
      required this.placeTour,
      required this.timeStart,
      required this.startDay,
      required this.startMonth,
      required this.startYear,
      required this.imageTourDetails,
      required this.description,
      required this.dayEnd,
      required this.hotel});

  Map<String, dynamic> toJson() => {
        'idTourDetail': idTourDetails,
        'idTour': idTour,
        'placeTour': placeTour,
        'timeStart': timeStart,
        'startDay': startDay,
        'startMonth': startMonth,
        'startYear': startYear,
        'dayEnd': dayEnd,
        'imageTourDetails': imageTourDetails,
        'description': description,
        'hotel': hotel
      };

  //Lấy từ trên FirebaseStore xuống
  static tourDetails fromJson(Map<String, dynamic> json) => tourDetails(
      idTourDetails: json['idTourDetails'].toString(),
      idTour: json['idTour'].toString(),
      placeTour: json['placeTour'].toString(),
      timeStart: json['timeStart'].toString(),
      startDay: json['startDay'],
      startMonth: json['startMonth'],
      startYear: json['startYear'],
      dayEnd: json['dayEnd'],
      imageTourDetails: json['imageTourDetails'].toString(),
      description: json['description'].toString(),
      hotel: json['hotel'].toString());
}