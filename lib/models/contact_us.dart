class ContactUs {
  List<Records>? records;
  Null? record;
  String? code;
  String? status;
  String? message;

  ContactUs({this.records, this.record, this.code, this.status, this.message});

  ContactUs.fromJson(Map<String, dynamic> json) {
    if (json['records'] != null) {
      records = <Records>[];
      json['records'].forEach((v) {
        records!.add(new Records.fromJson(v));
      });
    }
    record = json['record'];
    code = json['code'];
    status = json['status'];
    message = json['message'];
  }

 }

class Records {
  int? id;
  String? aboutApp;
  String? ourVision;
  String? ourGoals;
  String? insatLink;
  String? faceebokkLink;
  String? linkdLinLink;
  String? twitterLink;

  Records(
      {this.id,
        this.aboutApp,
        this.ourVision,
        this.ourGoals,
        this.insatLink,
        this.faceebokkLink,
        this.linkdLinLink,
        this.twitterLink});

  Records.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    aboutApp = json['about_App'];
    ourVision = json['our_Vision'];
    ourGoals = json['our_Goals'];
    insatLink = json['insat_Link'];
    faceebokkLink = json['faceebokk_Link'];
    linkdLinLink = json['linkdLin_Link'];
    twitterLink = json['twitter_Link'];
  }

 }