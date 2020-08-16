// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:res/data/classes/abstract/query_model.dart';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order extends QueryModel {
    Order({
        this.success,
        this.data,
        this.error,
    });

    final bool success;
    final List<Datum> data;
    final String error;

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        error: json["error"] == null ? null : json["error"],
    );

    Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
        "error": error == null ? null : error,
    };

  @override
  Future loadData([BuildContext context]) async {
  

        if (1==1) {
      // Add parsed item
      orderFromJson(await fetchData('http://192.168.1.14:8000/api/dish'));
     
      finishLoading();
    }

    return null;
  }
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
        this.num,
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
    final int num;
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
        num: json["num"] == null ? null : json["num"],
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
        "num": num == null ? null : num,
        "rateing": rateing == null ? null : rateing,
        "country": country == null ? null : country,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    };
}
