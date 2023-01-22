import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:proje/CutomAppBar.dart';

import 'package:proje/main.dart';

import 'package:proje/model/ilanlar.dart';

import 'package:proje/view/ilan_view_model.dart';
import 'package:provider/provider.dart';

class IlanlarimListPage extends StatefulWidget {
  @override
  State<IlanlarimListPage> createState() => _IlanlarimListPageState();
}

class _IlanlarimListPageState extends State<IlanlarimListPage> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    List<DocumentSnapshot> products = [];
    var user = _auth.currentUser;
    var userId = user?.uid ?? "";
    return ChangeNotifierProvider<IlanViews>(
        create: (_) => IlanViews(),
        builder: (context, child) => Scaffold(
            appBar: CutomAppBar(),
            body: Container(
              child: Center(
                  child: Column(children: [
                Expanded(
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: FirebaseFirestore.instance
                          .collection("products")
                          .where("kullanici_id", isEqualTo: userId)
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
  IlanViews _ilanViews = IlanViews();
  bool isFiltering = false;
  late List<Ilanlar> filteredList;
  Widget build(BuildContext context) {
    var fullist = widget.productList;

// Kullanıcının eklediği ürünleri çek

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
                                          onTap: () async {
                                            _ilanViews.removeData(
                                                list[index].product_name);
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Icon(
                                                Icons.delete,
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
                                  Text(list[index].product_name),
                                  Text(list[index].price)
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
