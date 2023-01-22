import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proje/pages/home.dart';
import 'package:proje/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../service/auth.dart';
import 'dart:async';

class KayitOl extends StatelessWidget {
  final _fireStore = FirebaseFirestore.instance;

  static const routeName = '/signup-screen';

  final nameController = TextEditingController();
  final lastnameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final userNameControl = TextEditingController();
  var _authService = Auth();

  Widget signUpWith(IconData icon) {
    return Container(
      height: 50,
      width: 115,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.4), width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24),
          TextButton(onPressed: () {}, child: Text('Sign in')),
        ],
      ),
    );
  }

  Widget userInput(TextEditingController userInput, String hintTitle,
      TextInputType keyboardType) {
    return Container(
      height: 55,
      margin: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
          color: Color.fromARGB(179, 255, 255, 255),
          borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 15, right: 20),
        child: TextField(
          controller: userInput,
          autocorrect: false,
          enableSuggestions: false,
          autofocus: false,
          decoration: InputDecoration.collapsed(
            hintText: hintTitle,
            hintStyle: TextStyle(
                fontSize: 18,
                color: Color.fromARGB(179, 255, 255, 255),
                fontStyle: FontStyle.italic),
          ),
          keyboardType: keyboardType,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color.fromARGB(255, 210, 187, 246)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 500,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 35, 1, 72),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      userInput(nameController, 'Adı', TextInputType.name),
                      userInput(
                          lastnameController, 'Soyadı', TextInputType.name),
                      userInput(phoneController, 'Telefon Numarası',
                          TextInputType.phone),
                      userInput(
                          userNameControl, 'Kullanıcı Adı', TextInputType.name),
                      userInput(
                          emailController, 'Email', TextInputType.emailAddress),
                      userInput(passwordController, 'Şifre',
                          TextInputType.visiblePassword),
                      SizedBox(height: 10),
                      Container(
                        height: 47,
                        padding:
                            const EdgeInsets.only(top: 5, left: 70, right: 70),
                        child: InkWell(
                          onTap: () {
                            _authService
                                .register(
                                    nameController.text,
                                    lastnameController.text,
                                    userNameControl.text,
                                    emailController.text,
                                    passwordController.text,
                                    int.parse(phoneController.text))
                                .then((value) {
                              return Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            });
                          },
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(172, 244, 243, 247),
                                    border: Border.all(
                                        color:
                                            Color.fromARGB(47, 239, 212, 247),
                                        width: 2),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Center(
                                    child: Text(
                                      "Kaydol",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 35, 1, 72),
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 47,
                        padding:
                            const EdgeInsets.only(top: 5, left: 70, right: 70),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(172, 244, 243, 247),
                                    border: Border.all(
                                        color:
                                            Color.fromARGB(47, 239, 212, 247),
                                        width: 2),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Center(
                                    child: Text(
                                      "Giriş Yap",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 35, 1, 72),
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
