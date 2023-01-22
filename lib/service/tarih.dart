import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Calculator {
  static String dateTimeToString(DateTime dateTime) {
    String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
    return formattedDate;
  }

  static Timestamp datetimeToTimestamp(DateTime dateTime) {
    return Timestamp.fromDate(dateTime);
  }

  static DateTime datetimeFromTimestamp(Timestamp timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
  }
}
