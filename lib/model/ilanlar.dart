import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Ilanlar {
  final String product_name;
  final String price;
  final String categories;
  final String image;
  String eklenme_tarihi;
  String kullanici_id;
  String kullanici_email;

  Ilanlar({
    required this.product_name,
    required this.price,
    required this.categories,
    required this.image,
    required this.eklenme_tarihi,
    required this.kullanici_id,
    required this.kullanici_email,
  });

  factory Ilanlar.fromSnapshot(DocumentSnapshot snapshot) {
    return Ilanlar(
        product_name: snapshot["product_name"],
        price: snapshot["price"],
        categories: snapshot["categories"],
        image: snapshot["image"],
        eklenme_tarihi: snapshot["eklenme_tarihi"],
        kullanici_id: snapshot['kullanici_id'],
        kullanici_email: snapshot['kullanici_email']);
  }
  Map<String, dynamic> toMap() => {
        'product_name': product_name,
        'price': price,
        'categoires': categories,
        'image': image,
        'eklenme_tarihi': eklenme_tarihi,
        'kullanici_id': kullanici_id,
        'kullanici_mail': kullanici_email
      };

  factory Ilanlar.fromMap(map) => Ilanlar(
      product_name: map['product_name'] ?? "",
      price: map['price'] ?? "",
      categories: map['categories'] ?? "",
      eklenme_tarihi: map['eklenme_tarihi'] ?? "",
      image: map['image'] ?? "",
      kullanici_id: map['kullanici_id'] ?? "",
      kullanici_email: map['kullanici_email'] ?? "");
}

/*

 final String id;
  final String product_name;
  final String price;
  final String categories; 
  final String eklenme_tarihi;

  Ilanlar(
      {required this.id,
      required this.product_name,
      required this.price,
      required this.categories,
      required this.eklenme_tarihi,});


*/