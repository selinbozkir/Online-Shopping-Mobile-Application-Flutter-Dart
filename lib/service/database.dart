import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getUrunListFromApi(String referencePath) {
    return _firestore.collection(referencePath).snapshots();
  }

  Future<void> deleteDocument(
      {required String referecePath, String? product_name}) async {
    await _firestore.collection(referecePath).doc(product_name).delete();
  }
}
