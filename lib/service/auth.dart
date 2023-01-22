import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final _firebaseAuth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;

  Future<User?> signIn(String email, String password) async {
    var user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.user;
  }

  Future<User?> signInAnonymously() async {
    try {
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      print("Signed in with temporary account.");
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
      }
    }
  }

  Future<User?> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<User?> register(String name, String lastname, String username,
      String email, String password, int phoneNumara) async {
    var user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    await _fireStore.collection("users").doc(user.user!.uid).set({
      'phoneNumara': phoneNumara,
      'name': name,
      'lastname': lastname,
      'username': username,
      'email': email,
      'password': password,
    });
    return user.user;
  }
}
