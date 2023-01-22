import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class KullaniciViewModel extends ChangeNotifier {
  final String _collectionPath = 'users';
  getKullaniciList() {
    var streamListDocument =
        FirebaseFirestore.instance.collection(_collectionPath).snapshots();
    return streamListDocument;
  }
}
