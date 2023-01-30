import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebook/models/bookmodel.dart';
import 'package:flutter/foundation.dart';

import '../services/firebaseServices.dart';

class BookRepository with ChangeNotifier {
  CollectionReference<BookModel> bookRef =
      FirebaseService.db.collection("books").withConverter<BookModel>(
            fromFirestore: (snapshot, _) {
              return BookModel.fromFirebaseSnapshot(snapshot);
            },
            toFirestore: (model, _) => model.toJson(),
          );

  Stream<QuerySnapshot<BookModel>> getBook() {
    Stream<QuerySnapshot<BookModel>> response = bookRef.snapshots();
    return response;
  }

  Future<DocumentSnapshot<BookModel>> getOneBook(String id) async {
    try {
      final response = await bookRef.doc(id).get();

      if (!response.exists) {
        throw Exception("Book doesnot exists");
      }
      return response;
    } catch (err) {
      print(err);
      rethrow;
    }
  }
}
