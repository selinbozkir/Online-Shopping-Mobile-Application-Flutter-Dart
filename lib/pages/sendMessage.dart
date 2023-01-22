import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/message.dart';
import 'messagePage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SendMessagePage extends StatefulWidget {
  final String receiverId;

  SendMessagePage({required this.receiverId});

  @override
  _SendMessagePageState createState() => _SendMessagePageState();
}

class _SendMessagePageState extends State<SendMessagePage> {
  final _formKey = GlobalKey<FormState>();
  String? _message;

  @override
  Widget build(BuildContext context) {
    var receiverId = widget.receiverId;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var user = _auth.currentUser;
    var userId = user?.uid ?? "";
    return Scaffold(
      appBar: AppBar(
        title: Text('Mesaj Gönder'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Mesaj'),
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Lütfen mesaj giriniz';
                      }
                      return null;
                    },
                    onSaved: (value) => _message = value,
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    child: Text('Gönder'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        final FirebaseFirestore _db =
                            FirebaseFirestore.instance;
                        _db
                            .collection('users')
                            .doc(receiverId)
                            .collection('messages')
                            .add({
                          'senderId': userId,
                          'receiverId': receiverId,
                          'message': _message,
                          'timestamp': FieldValue.serverTimestamp()
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MessagesPage()));
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
