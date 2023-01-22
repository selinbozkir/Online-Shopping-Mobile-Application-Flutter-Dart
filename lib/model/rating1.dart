import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:proje/CutomAppBar.dart';

class Rating extends StatefulWidget {
  const Rating({Key? key}) : super(key: key);

  @override
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  double? _ratingValue;
  String Ad = "Ad"; // Ad değişkeni ilk değer atandı

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CutomAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: Center(
            child: Column(
              children: [
                const Text(
                  'Puanınız nedir?',
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 25),
                RatingBar(
                    initialRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    ratingWidget: RatingWidget(
                        full: const Icon(Icons.star, color: Colors.orange),
                        half: const Icon(
                          Icons.star_half,
                          color: Colors.orange,
                        ),
                        empty: const Icon(
                          Icons.star_outline,
                          color: Colors.orange,
                        )),
                    onRatingUpdate: (value) {
                      setState(() {
                        _ratingValue = value;
                      });
                    }),
                const SizedBox(height: 25),
                ElevatedButton(
                  child: Text("Gönder"),
                  onPressed: () {
                    _addRatingToFirestore();
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        ));
  }

  void _addRatingToFirestore() {
    if (_ratingValue != null && Ad != null) {
      final ratingsCollection = FirebaseFirestore.instance
          .collection("Rating")
          .add({"rating": _ratingValue, "Ad": Ad});
    }
  }

  void addRating(String rater, String ratee, int rating) {
    FirebaseFirestore.instance
        .collection("Rating")
        .where("email", isEqualTo: ratee)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        FirebaseFirestore.instance
            .collection("Rating")
            .doc(querySnapshot.docs.first.id)
            .update({
          "name": ratee,
        });
      } else {
        FirebaseFirestore.instance.collection("Rating").add({
          "name": ratee,
          "email": ratee,
        });
      }
    });

    FirebaseFirestore.instance.collection("Rating").add({
      "rater": rater,
      "ratee": ratee,
      "rating": rating,
    });
  }
}
