import 'package:proje/CutomAppBar.dart';
import 'package:proje/model/kullanici_model.dart';
import 'package:proje/pages/profilsayfas─▒.dart';
import 'package:proje/pages/login.dart';
import 'package:proje/pages/messagePage.dart';
import 'package:proje/pages/urunlerim.dart';
import 'package:proje/service/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../view/urunekle.dart';
import 'package:proje/view/urun_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Auth authService = Auth();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = _firebaseAuth.currentUser;
    var userId = user?.email ?? "";
    return Scaffold(
      appBar: CutomAppBar(),
      body: IlanListPage(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(''),
              accountEmail: Text(""),
            ),
            ListTile(
              title: Text('Anasayfa'),
              leading: Icon(Icons.home),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => IlanListPage())));
              },
            ),
            ListTile(
              title: Text('Profilim'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => ProfilListPage(
                              userid: userId,
                            ))));
              },
              leading: Icon(Icons.person),
            ),
            ListTile(
              title: Text('─░lanlar─▒m'),
              leading: Icon(Icons.list_alt_outlined),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => IlanlarimListPage())));
              },
            ),
            ListTile(
              title: Text('├ťr├╝n Ekle'),
              leading: Icon(Icons.add_a_photo_rounded),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => UrunEkle())));
              },
            ),
            ListTile(
              title: Text('Mesajlar─▒m'),
              leading: Icon(Icons.notification_important),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => MessagesPage())));
              },
            ),
            ListTile(
              title: Text('├ç─▒k─▒┼č yap'),
              onTap: () {
                authService.signOut().then((value) {
                  return Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                });
                Navigator.pop(context);
              },
              leading: Icon(Icons.remove_circle),
            ),
          ],
        ),
      ),
    );
  }
}
