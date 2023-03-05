// To parse this JSON data, do
//
//     final categoryIdModel = categoryIdModelFromJson(jsonString);

import 'dart:convert';

CategoryIdModel categoryIdModelFromJson(String str) => CategoryIdModel.fromJson(json.decode(str));

String categoryIdModelToJson(CategoryIdModel data) => json.encode(data.toJson());

class CategoryIdModel {
  CategoryIdModel({
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

  factory CategoryIdModel.fromJson(Map<String, dynamic> json) => CategoryIdModel(
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
    required this.storTitle,
    required this.storImgUrl,
    required this.storLink,
    required this.storDeteils,
    required this.storOffer,
    required this.storSaleCode,
    required this.storPhoneNumber,
    required this.storAddress,
    required this.acceptLocoCard,
    required this.catgId,
    required this.categories,
    required this.countId,
    required this.countries,
  });

  dynamic photo;
  int id;
  String storTitle;
  String storImgUrl;
  String storLink;
  String storDeteils;
  String storOffer;
  String storSaleCode;
  String storPhoneNumber;
  String storAddress;
  bool acceptLocoCard;
  int catgId;
  Categories categories;
  int countId;
  Countries countries;

  factory Record.fromJson(Map<String, dynamic> json) => Record(
    photo: json["photo"],
    id: json["id"],
    storTitle: json["stor_Title"],
    storImgUrl: json["stor_ImgUrl"],
    storLink: json["stor_Link"],
    storDeteils: json["stor_Deteils"],
    storOffer: json["stor_Offer"],
    storSaleCode: json["stor_SaleCode"],
    storPhoneNumber: json["stor_PhoneNumber"],
    storAddress: json["stor_Address"],
    acceptLocoCard: json["accept_Loco_Card"],
    catgId: json["catgId"],
    categories: Categories.fromJson(json["categories"]),
    countId: json["countId"],
    countries: Countries.fromJson(json["countries"]),
  );

  Map<String, dynamic> toJson() => {
    "photo": photo,
    "id": id,
    "stor_Title": storTitle,
    "stor_ImgUrl": storImgUrl,
    "stor_Link": storLink,
    "stor_Deteils": storDeteils,
    "stor_Offer": storOffer,
    "stor_SaleCode": storSaleCode,
    "stor_PhoneNumber": storPhoneNumber,
    "stor_Address": storAddress,
    "accept_Loco_Card": acceptLocoCard,
    "catgId": catgId,
    "categories": categories.toJson(),
    "countId": countId,
    "countries": countries.toJson(),
  };
}

class Categories {
  Categories({
    required this.id,
    required this.categName,
    required this.catedIconUrl,
    this.stores,
  });

  int id;
  String categName;
  String catedIconUrl;
  dynamic stores;

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
    id: json["id"],
    categName: json["categ_Name"],
    catedIconUrl: json["cated_IconUrl"],
    stores: json["stores"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "categ_Name": categName,
    "cated_IconUrl": catedIconUrl,
    "stores": stores,
  };
}

class Countries {
  Countries({
    required this.id,
    required this.contName,
    required this.contFlagUrl,
    this.stores,
  });

  int id;
  String contName;
  String contFlagUrl;
  dynamic stores;

  factory Countries.fromJson(Map<String, dynamic> json) => Countries(
    id: json["id"],
    contName: json["cont_Name"],
    contFlagUrl: json["cont_FlagUrl"],
    stores: json["stores"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cont_Name": contName,
    "cont_FlagUrl": contFlagUrl,
    "stores": stores,
  };
}
