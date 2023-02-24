import 'dart:convert';

import 'package:wiliams/DataBase/Entity.dart';


class ProductModel extends BaseEntity {
  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.brief,
    required this.details,
    required this.category,
    required this.image,
    required this.subcategories,
    required this.views,
    required this.sales,
    required this.amount,
  });

  final int id;
  final String name;
  final String price;
  final String brief;
  final String details;
  final String category;
  final String image;
  final String subcategories;
  final int views;
  final int sales;
  final int amount;

  static ProductModel fromJson(Map<String, dynamic> json) => ProductModel(
        id: int.tryParse(json["id"].toString()) ?? 0,
        name: json["name"],
        price: json["price"],
        brief: json["brief"],
        details: json["details"],
        category: json["category"],
        image: json["image"],
        subcategories: jsonEncode(json['subcategories']),
        views: json['views'] ?? 0,
        sales: json['sales'] ?? 0,
        amount: json['amount'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "brief": brief,
        "details": details,
        "category": category,
        "image": image,
        "subcategories": subcategories,
        "views": views,
        "sales": sales,
        "amount": amount,
      };

  static List<ProductModel> listFromJson(List data) {
    return data.map((e) => ProductModel.fromJson(e)).toList();
  }
}
