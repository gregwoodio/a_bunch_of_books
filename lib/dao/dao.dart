import 'dart:async';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'database.dart';
import '../models/models.dart' as models;

class DAO {
  final Database db;

  DAO(this.db);

  Stream<List<models.Reader>> getReaders() {
    StreamController<List<models.Reader>> ctrl =
        StreamController<List<models.Reader>>();

    db
        .customSelect(
            'SELECT r.*, COUNT(br.reader_id) as booksRead '
            'FROM reader r '
            'LEFT JOIN book_read br ON r.id = br.reader_id '
            'GROUP BY r.id',
            readsFrom: {
              db.reader,
              db.bookRead,
            })
        .watch()
        .listen((row) {
          ctrl.add(row.map((data) {
            return toReaderModel(data);
          }).toList());
        });

    return ctrl.stream;
  }

  void addReader(models.Reader reader) {
    db.into(db.reader).insert(
          ReaderCompanion(
            name: Value<String>(reader.name),
          ),
        );
  }

  Stream<List<models.Book>> getBooks({
    GeneratedColumn<String>? orderBy,
    OrderingMode mode = OrderingMode.asc,
  }) {
    StreamController<List<models.Book>> ctrl =
        StreamController<List<models.Book>>();

    orderBy ??= db.book.title;

    db.select(db.book)
      ..orderBy([
        (tbl) => OrderingTerm(expression: orderBy!, mode: mode),
      ])
      ..watch().listen((data) {
        ctrl.add(data.map(toBookModel).toList());
      });

    return ctrl.stream;
  }

  Future<List<models.Book>> searchBooks(String term) async {
    final query = db.select(db.book)
      ..where((t) => t.title.contains(term) | t.author.contains(term));

    return query.map(toBookModel).get();
  }

  models.Reader toReaderModel(QueryRow row) {
    final data = row.data;
    return models.Reader(
      id: data['id'],
      name: data['name'],
      image: data['image'],
      booksRead: data['booksRead'],
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
