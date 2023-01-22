import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:proje/main.dart';

import 'package:proje/model/ilanlar.dart';
import 'package:proje/pages/bilgisayfasi.dart';
import 'package:proje/pages/sendMessage.dart';

import 'package:proje/view/ilan_view_model.dart';
import 'package:provider/provider.dart';

class IlanListPage extends StatefulWidget {
  @override
  State<IlanListPage> createState() => _IlanListPageState();
}

class _IlanListPageState extends State<IlanListPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<IlanViews>(
        create: (_) => IlanViews(),
        builder: (context, child) => Scaffold(
                body: Container(
              child: Center(
                  child: Column(children: [
                Expanded(
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: FirebaseFirestore.instance
                          .collection("products")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        } else {
                          var data = snapshot.data!.docs;
                          var productList =
                              data.map((e) => Ilanlar.fromMap(e)).toList();
                          return BuildGridView(productList: productList);
                        }
                      }),
                ),
              ])),
            )));
  }
}

class BuildGridView extends StatefulWidget {
  const BuildGridView({
    required this.productList,
  });
  final List<Ilanlar> productList;
  @override
  _BuildGridViewState createState() => _BuildGridViewState();
}

class _BuildGridViewState extends State<BuildGridView> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool isFiltering = false;
  late List<Ilanlar> filteredList;
  Widget build(BuildContext context) {
    var fullist = widget.productList;

    return Flexible(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Ara',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0))),
            onChanged: (query) {
              if (query.isNotEmpty) {
                isFiltering = true;

                setState(() {
                  filteredList = fullist
                      .where((product) => product.product_name
                          .toLowerCase()
                          .contains(query.toLowerCase()))
                      .toList();
                });
              } else {
                WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                setState(() {
                  isFiltering = false;
                });
              }
            },
          ),
        ),
        Flexible(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 1.7 / 3),
                scrollDirection: Axis.vertical,
                itemCount: isFiltering ? filteredList.length : fullist.length,
                itemBuilder: ((context, index) {
                  var list = isFiltering ? filteredList : fullist;

                  return Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      child: Card(
                          color: Color.fromARGB(255, 236, 210, 245),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox.fromSize(
                                    size: Size(30, 30),
                                    child: ClipOval(
                                      child: Material(
                                        color:
                                            Color.fromARGB(255, 236, 210, 245),
                                        child: InkWell(
                                          onTap: () {
                                            var _receiverId = list[index]
                                                .kullanici_id
                                                .toString();

                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SendMessagePage(
                                                          receiverId:
                                                              _receiverId,
                                                        )));
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Icon(
                                                Icons.mail,
                                                size: 25,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Image.network(
                                  list[index].image,
                                  fit: BoxFit.fitWidth,
                                  height: 195,
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    list[index].product_name,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(list[index].price,
                                      style: TextStyle(fontSize: 18)),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BilgiListPage(
                                                    userid: list[index]
                                                        .kullanici_email,
                                                  )));
                                    },
                                    child: _gitsatici(),
                                  ),
                                ],
                              )
                            ],
                          )),
                    ),
                  );
                })))
      ],
    ));
  }
}

Widget _gitsatici() {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 1),
    decoration: BoxDecoration(
        border: Border.all(color: Color.fromARGB(255, 166, 42, 170), width: 2),
        borderRadius: BorderRadius.all(Radius.circular(30))),
    child: Padding(
      padding: const EdgeInsets.all(3.0),
      child: Center(
        child: Text(
          "Satıcıya git!",
          style: TextStyle(
            color: Color.fromARGB(255, 166, 42, 170),
            fontSize: 20,
          ),
        ),
      ),
    ),
  );
}
