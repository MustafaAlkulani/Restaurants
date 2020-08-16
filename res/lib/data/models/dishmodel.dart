// To parse this JSON data, do
//
//     final dishModel = dishModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

DishModel dishModelFromJson(String str) => DishModel.fromJson(json.decode(str));

String dishModelToJson(DishModel data) => json.encode(data.toJson());

class DishModel with ChangeNotifier {
  DishModel({
    this.success,
    this.data,
    this.error,
  });

  final bool success;
  final List<Datum> data;
  final String error;

  factory DishModel.fromJson(Map<String, dynamic> json) => DishModel(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        error: json["error"] == null ? null : json["error"],
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "error": error == null ? null : error,
      };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.name_ar,
    this.type,
    this.description,
    this.img,
    this.price,
    this.discount,
    this.isfavor,
    this.rateing,
    this.country,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final String name;
  final String name_ar;
  final int type;
  final String description;
  final String img;
  final int price;
  final int discount;
   bool isfavor;
  final int rateing;
  final String country;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        name_ar: json["name"] == null ? null : json["name"],
        type: json["type"] == null ? null : json["type"],
        description: json["description"] == null ? null : json["description"],
        img: json["img"] == null ? null : json["img"],
        price: json["price"] == null ? null : json["price"],
        discount: json["discount"] == null ? null : json["discount"],
        isfavor: json["isfavor"] == null
            ? null
            : json["isfavor"] == 0 ? false : true,
        rateing: json["rateing"] == null ? null : json["rateing"],
        country: json["country"] == null ? null : json["country"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "name_ar": name_ar == null ? null : name_ar,
        "type": type == null ? null : type,
        "description": description == null ? null : description,
        "img": img == null ? null : img,
        "price": price == null ? null : price,
        "discount": discount == null ? null : discount,
        "isfavor": isfavor == null ? null : isfavor,
        "rateing": rateing == null ? null : rateing,
        "country": country == null ? null : country,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}
