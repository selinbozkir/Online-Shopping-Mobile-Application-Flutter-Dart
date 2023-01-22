import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Users {
  late String email;
  late String password;
  late String name;
  late String lastname;
  late int phoneNumara;
  late final String username;

  Users({
    required this.email,
    required this.password,
    required this.name,
    required this.username,
    required this.lastname,
    required this.phoneNumara,
  });

  factory Users.fromSnapshot(DocumentSnapshot snapshot) {
    return Users(
      email: snapshot["email"],
      password: snapshot["password"],
      username: snapshot["username"],
      name: snapshot["name"],
      lastname: snapshot["lastname"],
      phoneNumara: snapshot["phoneNumara"],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'username': username,
      'name': name,
      'lastname': lastname,
      'phoneNumara': phoneNumara,
    };
  }

  factory Users.fromMap(map) {
    return Users(
      email: map["email"] ?? "",
      password: map["password"] ?? "",
      username: map["username"] ?? "",
      name: map["name"] ?? "",
      lastname: map["lastname"] ?? "",
      phoneNumara: map["phoneNumara"] ?? "",
    );
  }
}
