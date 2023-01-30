import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebook/models/bookmodel.dart';
import 'package:ebook/repositories/bookRepositories.dart';
import 'package:flutter/cupertino.dart';

class BookViewModel with ChangeNotifier {
  BookRepository _bookRepository = BookRepository();
  Stream<QuerySnapshot<BookModel>>? _book;
  Stream<QuerySnapshot<BookModel>>? get book => _book;

  Future<void> getBook() async {
    var response = _bookRepository.getBook();
    _book = response;
    notifyListeners();
  }
}
