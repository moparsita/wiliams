// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

import '../DataBase/Entity.dart';

List<OrderModel> orderModelFromJson(String str) => List<OrderModel>.from(json.decode(str).map((x) => OrderModel.fromJson(x)));

String orderModelToJson(List<OrderModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderModel extends BaseEntity{
  OrderModel({
    required this.id,
    required this.parentId,
    required this.number,
    this.orderKey,
    required this.createdVia,
    required this.version,
    required this.status,
    required this.currency,
    required this.dateCreated,
    required this.dateCreatedGmt,
    required this.dateModified,
    required this.dateModifiedGmt,
    required this.discountTotal,
    required this.discountTax,
    required this.shippingTotal,
    required this.shippingTax,
    required this.cartTax,
    required this.total,
    required this.totalTax,
    required this.pricesIncludeTax,
    required this.customerId,
    required this.customerIpAddress,
    required this.customerUserAgent,
    required this.customerNote,
    required this.billing,
    required this.shipping,
    required this.paymentMethod,
    required this.paymentMethodTitle,
    this.transactionId,
    this.datePaid,
    this.datePaidGmt,
    this.dateCompleted,
    this.dateCompletedGmt,
    required this.cartHash,
    this.metaData,
    this.lineItems,
    this.taxLines,
    this.shippingLines,
  });

  int id;
  int parentId;
  String number;
  String? orderKey;
  String createdVia;
  String version;
  String status;
  String currency;
  String? dateCreated;
  String? dateCreatedGmt;
  String? dateModified;
  String? dateModifiedGmt;
  String discountTotal;
  String discountTax;
  String shippingTotal;
  String shippingTax;
  String cartTax;
  String total;
  String totalTax;
  bool pricesIncludeTax;
  int customerId;
  String customerIpAddress;
  String customerUserAgent;
  String customerNote;
  Ing billing;
  Ing shipping;
  String paymentMethod;
  String paymentMethodTitle;
  String? transactionId;
  String? datePaid;
  String? datePaidGmt;
  dynamic dateCompleted;
  dynamic dateCompletedGmt;
  String cartHash;
  List<MetaDatum>? metaData;
  List<LineItem>? lineItems;
  List<TaxLine>? taxLines;
  List<ShippingLine>? shippingLines;

  static OrderModel fromJson(Map<String, dynamic> json) => OrderModel(
    id: int.tryParse(json["id"].toString()) ?? 0,
    parentId: json["parent_id"] ?? 0,
    number: json["number"] ?? '',
    orderKey: json["order_key"] ?? '',
    createdVia: json["created_via"] ?? '',
    version: json["version"] ?? '',
    status: json["status"] ?? '',
    currency: json["currency"] ?? '',
    dateCreated: json["date_created"],
    dateCreatedGmt: json["date_created_gmt"],
    dateModified: json["date_modified"],
    dateModifiedGmt: json["date_modified_gmt"],
    discountTotal: json["discount_total"] ?? '',
    discountTax: json["discount_tax"] ?? '',
    shippingTotal: json["shipping_total"] ?? '',
    shippingTax: json["shipping_tax"] ?? '',
    cartTax: json["cart_tax"] ?? '',
    total: json["total"] ?? '',
    totalTax: json["total_tax"] ?? '',
    pricesIncludeTax: json["prices_include_tax"] ?? false,
    customerId: json["customer_id"] ?? 0,
    customerIpAddress: json["customer_ip_address"] ?? '',
    customerUserAgent: json["customer_user_agent"] ?? '',
    customerNote: json["customer_note"] ?? '',
    billing: Ing.fromJson(json["billing"]),
    shipping: Ing.fromJson(json["shipping"]),
    paymentMethod: json["payment_method"] ?? '',
    paymentMethodTitle: json["payment_method_title"] ?? '',
    transactionId: json["transaction_id"] ?? '',
    datePaid: json["date_paid"] ?? '',
    datePaidGmt: json["date_paid_gmt"] ?? '',
    dateCompleted: json["date_completed"] ?? '',
    dateCompletedGmt: json["date_completed_gmt"] ?? '',
    cartHash: json["cart_hash"] ?? '',
    metaData: MetaDatum.listFromJson(json["meta_data"] ?? []),
    lineItems: LineItem.listFromJson(json["line_items"] ?? []),
    taxLines: TaxLine.listFromJson(json["tax_lines"] ?? []),
    shippingLines: ShippingLine.listFromJson(json["shipping_lines"] ?? []),

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "parent_id": parentId,
    "number": number,
    "order_key": orderKey,
    "created_via": createdVia,
    "version": version,
    "status": status,
    "currency": currency,
    "date_created": dateCreated,
    "date_created_gmt": dateCreatedGmt,
    "date_modified": dateModified,
    "date_modified_gmt": dateModifiedGmt,
    "discount_total": discountTotal,
    "discount_tax": discountTax,
    "shipping_total": shippingTotal,
    "shipping_tax": shippingTax,
    "cart_tax": cartTax,
    "total": total,
    "total_tax": totalTax,
    "prices_include_tax": pricesIncludeTax,
    "customer_id": customerId,
    "customer_ip_address": customerIpAddress,
    "customer_user_agent": customerUserAgent,
    "customer_note": customerNote,
    "billing": billing.toJson(),
    "shipping": shipping.toJson(),
    "payment_method": paymentMethod,
    "payment_method_title": paymentMethodTitle,
    "transaction_id": transactionId,
    "date_paid": datePaid,
    "date_paid_gmt": datePaidGmt,
    "date_completed": dateCompleted,
    "date_completed_gmt": dateCompletedGmt,
    "cart_hash": cartHash,
    "meta_data": List<dynamic>.from(metaData!.map((x) => x.toJson())),
    "line_items": List<dynamic>.from(lineItems!.map((x) => x.toJson())),
    "tax_lines": List<dynamic>.from(taxLines!.map((x) => x.toJson())),
    "shipping_lines": List<dynamic>.from(shippingLines!.map((x) => x.toJson())),

  };

  static List<OrderModel> listFromJson(List data) {
    return data.map((e) => OrderModel.fromJson(e)).toList();
  }
}

class Ing {
  Ing({
    required this.firstName,
    required this.lastName,
    required this.company,
    required this.address1,
    required this.address2,
    required this.city,
    required this.state,
    required this.postcode,
    required this.country,
    this.email,
    this.phone,
  });

  String firstName;
  String lastName;
  String company;
  String address1;
  String address2;
  String city;
  String state;
  String postcode;
  String country;
  String? email;
  String? phone;

  factory Ing.fromJson(Map<String, dynamic> json) => Ing(
    firstName: json["first_name"],
    lastName: json["last_name"],
    company: json["company"],
    address1: json["address_1"],
    address2: json["address_2"],
    city: json["city"],
    state: json["state"],
    postcode: json["postcode"],
    country: json["country"],
    email: json["email"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "company": company,
    "address_1": address1,
    "address_2": address2,
    "city": city,
    "state": state,
    "postcode": postcode,
    "country": country,
    "email": email,
    "phone": phone,
  };

  static List<Ing>? listFromJson(List? data) {
    return data?.map((e) => Ing.fromJson(e)).toList();
  }
}

class LineItem {
  LineItem({
    required this.id,
    required this.name,
    required this.productId,
    required this.variationId,
    required this.quantity,
    required this.taxClass,
    required this.subtotal,
    required this.subtotalTax,
    required this.total,
    required this.totalTax,
    required this.taxes,
    required this.metaData,
    this.sku,
    required this.price,
  });

  int id;
  String name;
  int productId;
  int variationId;
  int quantity;
  String taxClass;
  String subtotal;
  String subtotalTax;
  String total;
  String totalTax;
  List<Tax> taxes;
  List<MetaDatum> metaData;
  String? sku;
  int price;

  factory LineItem.fromJson(Map<String, dynamic> json) => LineItem(
    id: json["id"],
    name: json["name"],
    productId: json["product_id"],
    variationId: json["variation_id"],
    quantity: json["quantity"],
    taxClass: json["tax_class"],
    subtotal: json["subtotal"],
    subtotalTax: json["subtotal_tax"],
    total: json["total"],
    totalTax: json["total_tax"],
    taxes: List<Tax>.from(json["taxes"].map((x) => Tax.fromJson(x))),
    metaData: List<MetaDatum>.from(json["meta_data"].map((x) => MetaDatum.fromJson(x))),
    sku: json["sku"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "product_id": productId,
    "variation_id": variationId,
    "quantity": quantity,
    "tax_class": taxClass,
    "subtotal": subtotal,
    "subtotal_tax": subtotalTax,
    "total": total,
    "total_tax": totalTax,
    "taxes": List<dynamic>.from(taxes.map((x) => x.toJson())),
    "meta_data": List<dynamic>.from(metaData.map((x) => x.toJson())),
    "sku": sku,
    "price": price,
  };

  static List<LineItem>? listFromJson(List? data) {
    return data?.map((e) => LineItem.fromJson(e)).toList();
  }
}

class MetaDatum {
  MetaDatum({
    required this.id,
    required this.key,
    required this.value,
  });

  int id;
  String key;
  String value;

  factory MetaDatum.fromJson(Map<String, dynamic> json) => MetaDatum(
    id: json["id"],
    key: json["key"] ?? '',
    value: json["value"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "key": key,
    "value": value,
  };

  static List<MetaDatum>? listFromJson(List? data) {
    return data?.map((e) => MetaDatum.fromJson(e)).toList();
  }
}

class Tax {
  Tax({
    required this.id,
    required this.total,
    required this.subtotal,
  });

  int id;
  String total;
  String subtotal;

  factory Tax.fromJson(Map<String, dynamic> json) => Tax(
    id: json["id"],
    total: json["total"],
    subtotal: json["subtotal"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "total": total,
    "subtotal": subtotal,
  };

  static List<Tax>? listFromJson(List? data) {
    return data?.map((e) => Tax.fromJson(e)).toList();
  }
}

class Links {
  Links({
    required this.self,
    required this.collection,
  });

  List<Collection> self;
  List<Collection> collection;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    self: List<Collection>.from(json["self"].map((x) => Collection.fromJson(x))),
    collection: List<Collection>.from(json["collection"].map((x) => Collection.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "self": List<dynamic>.from(self.map((x) => x.toJson())),
    "collection": List<dynamic>.from(collection.map((x) => x.toJson())),
  };

  static List<Links>? listFromJson(List? data) {
    return data?.map((e) => Links.fromJson(e)).toList();
  }
}

class Collection {
  Collection({
    required this.href,
  });

  String href;

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "href": href,
  };

  static List<Collection>? listFromJson(List? data) {
    return data?.map((e) => Collection.fromJson(e)).toList();
  }
}

class ShippingLine {
  ShippingLine({
    required this.id,
    required this.methodTitle,
    required this.methodId,
    required this.total,
    required this.totalTax,
    required this.taxes,
    required this.metaData,
  });

  int id;
  String methodTitle;
  String methodId;
  String total;
  String totalTax;
  List<dynamic> taxes;
  List<dynamic> metaData;

  factory ShippingLine.fromJson(Map<String, dynamic> json) => ShippingLine(
    id: json["id"],
    methodTitle: json["method_title"],
    methodId: json["method_id"],
    total: json["total"],
    totalTax: json["total_tax"],
    taxes: List<dynamic>.from(json["taxes"].map((x) => x)),
    metaData: List<dynamic>.from(json["meta_data"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "method_title": methodTitle,
    "method_id": methodId,
    "total": total,
    "total_tax": totalTax,
    "taxes": List<dynamic>.from(taxes.map((x) => x)),
    "meta_data": List<dynamic>.from(metaData.map((x) => x)),
  };

  static List<ShippingLine>? listFromJson(List? data) {
    return data?.map((e) => ShippingLine.fromJson(e)).toList();
  }
}

class TaxLine {
  TaxLine({
    required this.id,
    required this.rateCode,
    required this.rateId,
    required this.label,
    required this.compound,
    required this.taxTotal,
    required this.shippingTaxTotal,
    required this.metaData,
  });

  int id;
  String rateCode;
  int rateId;
  String label;
  bool compound;
  String taxTotal;
  String shippingTaxTotal;
  List<dynamic> metaData;

  factory TaxLine.fromJson(Map<String, dynamic> json) => TaxLine(
    id: json["id"],
    rateCode: json["rate_code"],
    rateId: json["rate_id"],
    label: json["label"],
    compound: json["compound"],
    taxTotal: json["tax_total"],
    shippingTaxTotal: json["shipping_tax_total"],
    metaData: List<dynamic>.from(json["meta_data"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rate_code": rateCode,
    "rate_id": rateId,
    "label": label,
    "compound": compound,
    "tax_total": taxTotal,
    "shipping_tax_total": shippingTaxTotal,
    "meta_data": List<dynamic>.from(metaData.map((x) => x)),
  };

  static List<TaxLine>? listFromJson(List? data) {
    return data?.map((e) => TaxLine.fromJson(e)).toList();
  }
}
