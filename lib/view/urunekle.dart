import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:proje/view/ilan_view_model.dart';
import 'package:proje/view/categories_model.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UrunEkle extends StatefulWidget {
  @override
  State<UrunEkle> createState() => _UrunEkleState();
}

class _UrunEkleState extends State<UrunEkle> {
  final _firestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  TextEditingController urunAdi = TextEditingController();
  TextEditingController urunFiyat = TextEditingController();
  IlanViews _ilanViews = IlanViews();

  String? selectedValue;
  final ImagePicker _imagePicker = ImagePicker();
  Kategori _category = Kategori();
  dynamic _pickImage;

  XFile? image;
  Widget imagePlace() {
    double height = MediaQuery.of(context).size.height;
    if (image != null) {
      return Container(
        height: 100,
        child: Image.file(File(image!.path)),
      );
    } else {
      if (_pickImage != null) {
        return Image.network(_pickImage);
      } else
        return Text("Görüntü Seçin");
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Ürün Ekle"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: size.height * .4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextField(
                          controller: urunAdi,
                          maxLines: 2,
                          decoration: InputDecoration(hintText: "Ürün Adı")),
                      SizedBox(),
                      TextField(
                          controller: urunFiyat,
                          maxLines: 2,
                          decoration: InputDecoration(hintText: "Fiyat Girin")),
                      SizedBox(),
                      Center(
                        child: imagePlace(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                              onTap: () => _onImageButtonPressed(
                                  ImageSource.camera,
                                  context: context),
                              child: Icon(
                                Icons.camera_alt,
                                size: 30,
                                color: Colors.blue,
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                              onTap: () => _onImageButtonPressed(
                                  ImageSource.gallery,
                                  context: context),
                              child: Icon(
                                Icons.image,
                                size: 30,
                                color: Colors.blue,
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: _category.getCategory(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return LinearProgressIndicator();

                if (snapshot.data != null) {
                  return DropdownButton2<String>(
                    isExpanded: true,
                    hint: Row(
                      children: const [
                        Icon(
                          Icons.list,
                          size: 40,
                          color: Color.fromARGB(255, 209, 40, 139),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Text(
                            'Kategori Seçin',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    items: snapshot.data!.docs
                        .map((document) => DropdownMenuItem<String>(
                              value: document.id,
                              child: Text(document['categories']),
                            ))
                        .toList(),
                    value: selectedValue,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value as String;
                      });
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 25),
              child: InkWell(
                onTap: () {
                  _ilanViews
                      .addData(
                    urunAdi.text,
                    urunFiyat.text,
                    selectedValue.toString(),
                    image,
                    firebaseAuth.currentUser?.uid ?? "",
                    firebaseAuth.currentUser?.email ?? "",
                  )
                      .then((value) {
                    Fluttertoast.showToast(
                        msg: "Ürün eklendi",
                        timeInSecForIosWeb: 2,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.grey[600],
                        textColor: Colors.white,
                        fontSize: 14);
                    Navigator.pop(context);
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 2),
                      //color: colorPrimaryShade,
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Center(
                        child: Text(
                      "Ekle",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                      ),
                    )),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onImageButtonPressed(ImageSource source,
      {required BuildContext context}) async {
    try {
      final pickedFile = await _imagePicker.pickImage(source: source);
      setState(() {
        image = pickedFile!;
        if (image != null) {}
      });
      print('aaa');
    } catch (e) {
      setState(() {
        _pickImage = e;
      });
    }
  }
}
