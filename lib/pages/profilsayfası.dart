import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proje/CutomAppBar.dart';
import 'package:proje/pages/sendMessage.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:proje/model/kullanici_model.dart';
import 'package:proje/model/kullanicilar.dart';
import 'package:proje/model/rating1.dart';

import 'package:provider/provider.dart';

class ProfilListPage extends StatefulWidget {
  const ProfilListPage({required this.userid});
  final userid;

  @override
  State<ProfilListPage> createState() => _ProfilListPageState();
}

class _ProfilListPageState extends State<ProfilListPage> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    List<DocumentSnapshot> users = [];

    var userId = widget.userid;
    return ChangeNotifierProvider<KullaniciViewModel>(
        create: (_) => KullaniciViewModel(),
        builder: (context, child) => Scaffold(
            appBar: CutomAppBar(),
            body: Container(
              child: Center(
                  child: Column(children: [
                Expanded(
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: FirebaseFirestore.instance
                          .collection("users")
                          .where("email", isEqualTo: userId)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        } else {
                          var data = snapshot.data!.docs;
                          var productList =
                              data.map((e) => Users.fromMap(e)).toList();
                          return BuildGridView(
                            productList: productList,
                            userId: userId,
                          );
                        }
                      }),
                ),
              ])),
            )));
  }
}

class BuildGridView extends StatefulWidget {
  const BuildGridView({required this.productList, required this.userId});
  final List<Users> productList;
  final String userId;
  @override
  _BuildGridViewState createState() => _BuildGridViewState();
}

class _BuildGridViewState extends State<BuildGridView> {
  Widget build(BuildContext context) {
    var fullist = widget.productList;
    var userid = widget.userId;
// Kullanıcının eklediği ürünleri çek

    return Flexible(
        child: Column(
      children: [
        Flexible(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1, childAspectRatio: 1 / 1),
                itemCount: fullist.length,
                itemBuilder: ((context, index) {
                  var list = fullist;

                  return Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GradientText(
                                style: TextStyle(fontSize: 48),
                                colors: [
                                  Color.fromARGB(255, 183, 101, 128),
                                  Color.fromARGB(255, 80, 101, 136),
                                  Color.fromARGB(255, 203, 196, 137)
                                ],
                                list[index].name),
                            GradientText(
                                style: TextStyle(fontSize: 48),
                                colors: [
                                  Color.fromARGB(255, 183, 101, 128),
                                  Color.fromARGB(255, 80, 101, 136),
                                  Color.fromARGB(255, 203, 196, 137)
                                ],
                                list[index].lastname),
                            GradientText(
                                style: TextStyle(fontSize: 30),
                                colors: [
                                  Color.fromARGB(255, 183, 101, 128),
                                  Color.fromARGB(255, 80, 101, 136),
                                  Color.fromARGB(255, 203, 196, 137)
                                ],
                                list[index].phoneNumara.toString()),
                            GradientText(
                                style: TextStyle(fontSize: 20),
                                colors: [
                                  Color.fromARGB(255, 183, 101, 128),
                                  Color.fromARGB(255, 80, 101, 136),
                                  Color.fromARGB(255, 203, 196, 137)
                                ],
                                list[index].email),
                            SizedBox(
                              height: 35,
                            ),
                          ],
                        )
                      ],
                    )),
                  );
                })))
      ],
    ));
  }
}
