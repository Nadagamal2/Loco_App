// To parse this JSON data, do
//
//     final countryModel = countryModelFromJson(jsonString);

import 'dart:convert';

CountryModel countryModelFromJson(String str) => CountryModel.fromJson(json.decode(str));

String countryModelToJson(CountryModel data) => json.encode(data.toJson());

class CountryModel {
  CountryModel({
    required this.records,
    this.record,
    required this.code,
    required this.status,
    required this.message,
  });

  List<Record> records;
  dynamic record;
  String code;
  String status;
  String message;

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
    records: List<Record>.from(json["records"].map((x) => Record.fromJson(x))),
    record: json["record"],
    code: json["code"],
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "records": List<dynamic>.from(records.map((x) => x.toJson())),
    "record": record,
    "code": code,
    "status": status,
    "message": message,
  };
}

class Record {
  Record({
    this.photo,
    required this.id,
    required this.contName,
    required this.contFlagUrl,
    this.stores,
  });

  dynamic photo;
  int id;
  String contName;
  String contFlagUrl;
  dynamic stores;

  factory Record.fromJson(Map<String, dynamic> json) => Record(
    photo: json["photo"],
    id: json["id"],
    contName: json["cont_Name"]??'',
    contFlagUrl: json["cont_FlagUrl"],
    stores: json["stores"],
  );

  Map<String, dynamic> toJson() => {
    "photo": photo,
    "id": id,
    "cont_Name": contName,
    "cont_FlagUrl": contFlagUrl,
    "stores": stores,
  };
}
