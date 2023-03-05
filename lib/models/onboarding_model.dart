class OnboardingModel {
  List<Records>? records;
  Null? record;
  String? code;
  String? status;
  String? message;

  OnboardingModel(
      {this.records, this.record, this.code, this.status, this.message});

  OnboardingModel.fromJson(Map<String, dynamic> json) {
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
  Null? photo;
  int? id;
  String? sliderImgUrl;
  String? title;
  String? subTitle;

  Records({this.photo, this.id, this.sliderImgUrl, this.title, this.subTitle});

  Records.fromJson(Map<String, dynamic> json) {
    photo = json['photo'];
    id = json['id'];
    sliderImgUrl = json['slider_ImgUrl'];
    title = json['title'];
    subTitle = json['sub_Title'];
  }

 }