import 'package:cloud_firestore/cloud_firestore.dart';

class Kategori {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getCategory() {
    var ref = _firestore.collection("category").snapshots();

    return ref;
  }

 
}