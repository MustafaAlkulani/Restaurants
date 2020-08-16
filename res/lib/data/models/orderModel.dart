// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

OrderModel orderModelFromJson(String str) => OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel with ChangeNotifier {
    OrderModel({
        this.success,
        this.data,
        this.error,
    });

    final bool success;
    final List<Datum> data;
    final String error;

    factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        error: json["error"] == null ? null : json["error"],
    );

    Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
        "error": error == null ? null : error,
    };
}

class Datum {
    Datum({
        this.id,
        this.name,
        this.img,
        this.type,
        this.description,
        this.price,
        this.discount,
        this.count,
        this.rateing,
        this.country,
        this.createdAt,
        this.updatedAt,
    });

    final int id;
    final String name;
    final String img;
    final int type;
    final String description;
    final int price;
    final int discount;
    final int count;
    final String rateing;
    final String country;
    final DateTime createdAt;
    final DateTime updatedAt;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        img: json["img"] == null ? null : json["img"],
        type: json["type"] == null ? null : json["type"],
        description: json["description"] == null ? null : json["description"],
        price: json["price"] == null ? null : json["price"],
        discount: json["discount"] == null ? null : json["discount"],
        count: json["count"] == null ? null : json["count"],
        rateing: json["rateing"] == null ? null : json["rateing"],
        country: json["country"] == null ? null : json["country"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "img": img == null ? null : img,
        "type": type == null ? null : type,
        "description": description == null ? null : description,
        "price": price == null ? null : price,
        "discount": discount == null ? null : discount,
        "count": count == null ? null : count,
        "rateing": rateing == null ? null : rateing,
        "country": country == null ? null : country,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    };
}
