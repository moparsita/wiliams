// To parse this JSON data, do
//
//     final customerModel = customerModelFromJson(jsonString);

import 'dart:convert';

import 'package:wiliams/DataBase/Entity.dart';
import 'package:wiliams/Plugins/my_dropdown/dropdown_item_model.dart';

CustomerModel customerModelFromJson(String str) => CustomerModel.fromJson(json.decode(str));

String customerModelToJson(CustomerModel data) => json.encode(data.toJson());

class CustomerModel extends BaseEntity with DropDownItemModel{
  CustomerModel({
    required this.id,
    required this.shop_name,
    required this.mobile,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.tel,
    required this.image,
    required this.shop_type,
  });

  int id;
  String shop_name;
  String mobile;
  String firstName;
  String lastName;
  String address;
  String tel;
  String image;
  String shop_type;

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
    id: int.tryParse(json["id"].toString()) ?? 0,
    shop_name: json["shop_name"] ?? '',
    mobile: json["mobile"] ?? '',
    firstName: json["first_name"] ?? '',
    lastName: json["last_name"] ?? '',
    address: json["address"] ?? '',
    tel: json["tel"] ?? '',
    image: json["image"] ?? '',
    shop_type: json["shop_type"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "shop_name": shop_name,
    "mobile": mobile,
    "first_name": firstName,
    "last_name": lastName,
    "address": address,
    "tel": tel,
    "image": image,
    "shop_type": shop_type,
  };

  static List<CustomerModel> listFromJson(List data) {
    return data.map((e) => CustomerModel.fromJson(e)).toList();
  }

  @override
  int dropdownId() {
    return id;
  }

  @override
  String dropdownTitle() {
    return shop_type + ' ' + shop_name + ' (' + firstName + ' ' + lastName + ')';
  }
}


class factorTypeModel extends DropDownItemModel {
  final int id;
  final String name;

  factorTypeModel({
    required this.id,
    required this.name,
  });

  factory factorTypeModel.fromMap(e) => factorTypeModel(
    id: e['id'] ?? 0,
    name: e['name'] ?? '',
  );

  @override
  int dropdownId() {
    return id;
  }

  @override
  String dropdownTitle() {
    return name;
  }
}


