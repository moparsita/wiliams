// To parse this JSON data, do
//
//     final factorModel = factorModelFromJson(jsonString);

import 'dart:convert';

List<FactorModel> factorModelFromJson(String str) => List<FactorModel>.from(json.decode(str).map((x) => FactorModel.fromJson(x)));

String factorModelToJson(List<FactorModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FactorModel {
  FactorModel({
    required this.factorId,
    required this.type,
    required this.number,
    required this.date,
    required this.customer,
    required this.visitorId,
    required this.price,
    required this.pos,
    required this.card,
    required this.cash,
    required this.cheque,
    required this.remain,
    required this.factorDetails,
  });

  int factorId;
  int type;
  String number;
  String date;
  Customer customer;
  int visitorId;
  String price;
  String pos;
  String card;
  String cash;
  String cheque;
  String remain;
  List<FactorDetail> factorDetails;

  factory FactorModel.fromJson(Map<String, dynamic> json) => FactorModel(
    factorId: json["factor_id"],
    type: json["type"],
    number: json["number"],
    date: json["date"],
    customer: Customer.fromJson(json["customer"]),
    visitorId: json["visitor_id"],
    price: json["price"],
    pos: json["pos"],
    card: json["card"],
    cash: json["cash"],
    cheque: json["cheque"],
    remain: json["remain"] ?? '',
    factorDetails: List<FactorDetail>.from(json["factor_details"].map((x) => FactorDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "factor_id": factorId,
    "type": type,
    "number": number,
    "date": date,
    "customer": customer.toJson(),
    "visitor_id": visitorId,
    "price": price,
    "pos": pos,
    "card": card,
    "cash": cash,
    "cheque": cheque,
    "remain": remain,
    "factor_details": List<dynamic>.from(factorDetails.map((x) => x.toJson())),
  };
  static List<FactorModel> listFromJson(List data) {
    return data.map((e) => FactorModel.fromJson(e)).toList();
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

  });

  int customerId;
  String firstName;
  String lastName;
  String mobile;
  int shopType;
  String shopName;
  String tel;
  String address;


  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    customerId: json["customer_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    mobile: json["mobile"],
    shopType: json["shop_type"],
    shopName: json["shop_name"],
    tel: json["tel"],
    address: json["address"],

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

  };
}

class FactorDetail {
  FactorDetail({
    required this.id,
    required this.factorId,
    required this.product,
    required this.amount,
    required this.price,
    required this.totalPrice,
  });

  int id;
  int factorId;
  Product product;
  String amount;
  String price;
  String totalPrice;

  factory FactorDetail.fromJson(Map<String, dynamic> json) => FactorDetail(
    id: json["id"],
    factorId: json["factor_id"],
    product: Product.fromJson(json["product"]),
    amount: json["amount"],
    price: json["price"],
    totalPrice: json["total_price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "factor_id": factorId,
    "product": product.toJson(),
    "amount": amount,
    "price": price,
    "total_price": totalPrice,
  };
}

class Product {
  Product({
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.productImage,
    required this.productDetails,
    required this.productBrief,
    required this.catId,
    this.subCats,
    this.productViews,
    this.productSales,
    required this.productAmount,
    required this.isConstructed,
    required this.createdAt,
  });

  int productId;
  String productName;
  String productPrice;
  String productImage;
  String productDetails;
  String productBrief;
  String catId;
  String? subCats;
  dynamic productViews;
  dynamic productSales;
  int productAmount;
  bool isConstructed;
  DateTime createdAt;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    productId: json["product_id"],
    productName: json["product_name"],
    productPrice: json["product_price"],
    productImage: json["product_image"],
    productDetails: json["product_details"],
    productBrief: json["product_brief"],
    catId: json["cat_id"],
    subCats: json["sub_cats"],
    productViews: json["product_views"],
    productSales: json["product_sales"],
    productAmount: json["product_amount"],
    isConstructed: json["isConstructed"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "product_name": productName,
    "product_price": productPrice,
    "product_image": productImage,
    "product_details": productDetails,
    "product_brief": productBrief,
    "cat_id": catId,
    "sub_cats": subCats,
    "product_views": productViews,
    "product_sales": productSales,
    "product_amount": productAmount,
    "isConstructed": isConstructed,
    "created_at": createdAt.toIso8601String(),
  };
}
