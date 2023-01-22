import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String id;
  String senderId;
  String receiverId;
  String message;
  DateTime timestamp;

  Message(
      {required this.id,
      required this.senderId,
      required this.receiverId,
      required this.message,
      required this.timestamp});

  factory Message.fromFirestore(DocumentSnapshot doc) {
    Map<dynamic, dynamic> data = doc.data() as Map;
    return Message(
      id: doc.id,
      senderId: data['senderId'],
      receiverId: data['receiverId'],
      message: data['message'],
      timestamp: data['timestamp'].toDate(),
    );
  }
}
