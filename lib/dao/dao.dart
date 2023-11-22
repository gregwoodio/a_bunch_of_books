import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'database.dart';
import '../models/models.dart' as models;

class DAO {
  final Database db;

  DAO(this.db);

  Stream<List<models.Reader>> getReaders() {
    StreamController<List<models.Reader>> ctrl =
        StreamController<List<models.Reader>>();

    db.select(db.reader).watch().listen((data) {
      ctrl.add(data.map(toReaderModel).toList());
    });

    return ctrl.stream;
  }

  Stream<List<models.Book>> getBooks() {
    StreamController<List<models.Book>> ctrl =
        StreamController<List<models.Book>>();

    db.select(db.book).watch().listen((data) {
      ctrl.add(data.map(toBookModel).toList());
    });

    return ctrl.stream;
  }

  models.Reader toReaderModel(ReaderData data) {
    return models.Reader(
      id: data.id,
      name: data.name,
      image: data.image,
    );
  }

  models.Book toBookModel(BookData data) {
    return models.Book(
      id: data.id,
      author: data.author,
      title: data.title,
      coverImage: data.coverImage,
      isbn: data.isbn,
    );
  }
}

final daoProvider = Provider.autoDispose((ref) => DAO(ref.read(dbProvider)));
