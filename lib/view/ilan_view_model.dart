import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proje/service/database.dart';
import '../model/ilanlar.dart';
import '../service/storage_service.dart';

class IlanViews extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  StorageService _storageService = StorageService();
  String mediaUrl = '';
  String _collectionPath = 'products';

  Database _database = Database();

  //ilan eklemek için
  Future<Ilanlar> addData(String product_name, String price, String categories,
      XFile? pickedFile, String kullanici_id, String kullanici_email) async {
    var ref = _firestore.collection("products");
    var user = firebaseAuth.currentUser;
    var user_email = user?.email ?? "";
    var userId = user?.uid ?? "";
    if (pickedFile != null) {
      mediaUrl = await _storageService.uploadMedia(File(pickedFile.path));
    }
    var documentRef = await ref.add({
      'product_name': product_name,
      'price': price,
      'categories': categories,
      'image': mediaUrl,
      'eklenme_tarihi': DateTime.now().toString(),
      'kullanici_id': userId,
      'kullanici_email': user_email
    });

    return Ilanlar(
      product_name: product_name,
      price: price,
      categories: categories,
      eklenme_tarihi: DateTime.now().toString(),
      image: mediaUrl,
      kullanici_id: userId,
      kullanici_email: user_email,
    );
  }

  Stream<QuerySnapshot> getData() {
    var ref = _firestore.collection("products").snapshots();

    return ref;
  }

  Future<void> removeData(String product_name) async {
    var collection = FirebaseFirestore.instance.collection('products');
    var snapshot =
        await collection.where('product_name', isEqualTo: product_name).get();
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }
}
