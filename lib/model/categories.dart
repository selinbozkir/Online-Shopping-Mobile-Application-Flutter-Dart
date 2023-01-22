import 'package:cloud_firestore/cloud_firestore.dart';

class Categories {
  final String id;
  final String categories;

  Categories({required this.id, required this.categories});

  factory Categories.fromSnapshot(DocumentSnapshot snapshot) {
    return Categories(
      id: snapshot.id,
      categories: snapshot["categories"],
    );
  }
}
