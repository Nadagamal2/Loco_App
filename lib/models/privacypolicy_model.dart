

import 'dart:convert';

PolicyModel policyModelFromJson(String str) => PolicyModel.fromJson(json.decode(str));


class PolicyModel {
  PolicyModel({
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

  factory PolicyModel.fromJson(Map<String, dynamic> json) => PolicyModel(
    records: List<Record>.from(json["records"].map((x) => Record.fromJson(x))),
    record: json["record"],
    code: json["code"],
    status: json["status"],
    message: json["message"],
  );


}

class Record {
  Record({
    required this.id,
    required this.deatils,
  });

  int id;
  String deatils;

  factory Record.fromJson(Map<String, dynamic> json) => Record(
    id: json["id"],
    deatils: json["deatils"],
  );


}
