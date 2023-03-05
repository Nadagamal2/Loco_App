//
//
// import 'dart:convert';
//
// CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));
//
//
// class CategoryModel {
//   CategoryModel({
//     required this.records,
//     this.record,
//     required this.code,
//     required this.status,
//     required this.message,
//   });
//
//   List<Record> records;
//   dynamic record;
//   String code;
//   String status;
//   String message;
//
//   factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
//     records: List<Record>.from(json["records"].map((x) => Record.fromJson(x))),
//     record: json["record"],
//     code: json["code"],
//     status: json["status"],
//     message: json["message"],
//   );
//
//  }
//
// class Record {
//   Record({
//     this.photo,
//     required this.id,
//     required this.categName,
//     required this.catedIconUrl,
//     this.stores,
//   });
//
//   dynamic photo;
//   int id;
//   String categName;
//   String catedIconUrl;
//   dynamic stores;
//
//   factory Record.fromJson(Map<String, dynamic> json) => Record(
//     photo: json["photo"],
//     id: json["id"],
//     categName: json["categ_Name"],
//     catedIconUrl: json["cated_IconUrl"],
//     stores: json["stores"],
//   );
//
//  }
class CategoryModel {
  int? id;
  String? categName;
  String? catedIconUrl;


  CategoryModel({
    this.id,
    this.categName,
    this.catedIconUrl,

  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      categName: json['categ_Name'],
      catedIconUrl: json['cated_IconUrl'],

    );
  }
}