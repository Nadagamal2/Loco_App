class ProfileDataModel {
  Record? record;
  String? code;
  String? status;
  String? message;

  ProfileDataModel({this.record, this.code, this.status, this.message});

  ProfileDataModel.fromJson(Map<String, dynamic> json) {
    record =
    json['record'] != null ? new Record.fromJson(json['record']) : null;
    code = json['code'];
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.record != null) {
      data['record'] = this.record!.toJson();
    }
    data['code'] = this.code;
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}

class Record {
  String? id;
  String? name;
  String? email;
  String? userNAme;
  String? phone;
  String? imgUrl;
  Null? gender;

  Record(
      {this.id,
        this.name,
        this.email,
        this.userNAme,
        this.phone,
        this.imgUrl,
        this.gender});

  Record.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    userNAme = json['userNAme'];
    phone = json['phone'];
    imgUrl = json['imgUrl'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['userNAme'] = this.userNAme;
    data['phone'] = this.phone;
    data['imgUrl'] = this.imgUrl;
    data['gender'] = this.gender;
    return data;
  }}