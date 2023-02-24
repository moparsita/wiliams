// To parse this JSON data, do
//
//     final unsuccessfulFactorModel = unsuccessfulFactorModelFromJson(jsonString);

import 'dart:convert';

List<UnsuccessfulFactorModel> unsuccessfulFactorModelFromJson(String str) => List<UnsuccessfulFactorModel>.from(json.decode(str).map((x) => UnsuccessfulFactorModel.fromJson(x)));

String unsuccessfulFactorModelToJson(List<UnsuccessfulFactorModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UnsuccessfulFactorModel {
  UnsuccessfulFactorModel({
    required this.factorId,
    required this.factorDescription,
    required this.date,
    required this.customer,
    required this.visitorId,
  });

  int factorId;
  String factorDescription;
  String date;
  Customer customer;
  int visitorId;

  factory UnsuccessfulFactorModel.fromJson(Map<String, dynamic> json) => UnsuccessfulFactorModel(
    factorId: json["factor_id"],
    factorDescription: json["factor_description"],
    date: json["date"],
    customer: Customer.fromJson(json["customer"]),
    visitorId: json["visitor_id"],
  );

  Map<String, dynamic> toJson() => {
    "factor_id": factorId,
    "factor_description": factorDescription,
    "date": date,
    "customer": customer.toJson(),
    "visitor_id": visitorId,
  };

  static List<UnsuccessfulFactorModel> listFromJson(List data) {
    return data.map((e) => UnsuccessfulFactorModel.fromJson(e)).toList();
  }
}

class Customer {
  Customer({
    required this.customerId,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.shopType,
    required this.shopName,
    required this.tel,
    required this.address,
    this.licenceImage,
    this.shopImage,
    this.standImage,
    required this.isConstructed,
    required this.createdAt,
  });

  int customerId;
  String firstName;
  String lastName;
  String mobile;
  int shopType;
  String shopName;
  String tel;
  String address;
  dynamic licenceImage;
  dynamic shopImage;
  dynamic standImage;
  bool isConstructed;
  DateTime createdAt;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    customerId: json["customer_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    mobile: json["mobile"],
    shopType: json["shop_type"],
    shopName: json["shop_name"],
    tel: json["tel"],
    address: json["address"],
    licenceImage: json["licence_image"],
    shopImage: json["shop_image"],
    standImage: json["stand_image"],
    isConstructed: json["isConstructed"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "customer_id": customerId,
    "first_name": firstName,
    "last_name": lastName,
    "mobile": mobile,
    "shop_type": shopType,
    "shop_name": shopName,
    "tel": tel,
    "address": address,
    "licence_image": licenceImage,
    "shop_image": shopImage,
    "stand_image": standImage,
    "isConstructed": isConstructed,
    "created_at": createdAt.toIso8601String(),
  };
}
