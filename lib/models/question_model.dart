

import 'dart:convert';

QuestionModel questionModelFromJson(String str) => QuestionModel.fromJson(json.decode(str));


class QuestionModel {
  QuestionModel({
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

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
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
    required this.question,
    required this.answer,
  });

  int id;
  String question;
  String answer;

  factory Record.fromJson(Map<String, dynamic> json) => Record(
    id: json["id"],
    question: json["question"],
    answer: json["answer"],
  );


}
