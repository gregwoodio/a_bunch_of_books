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
            'GROUP BY r.id ',
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

  Stream<List<models.Book>> getBooksRead(int readerID) {
    StreamController<List<models.Book>> ctrl =
        StreamController<List<models.Book>>();

    db
        .customSelect(
            'SELECT b.*, br.* from book_read br '
            'LEFT JOIN book b ON b.id == br.book_id '
            'WHERE br.reader_id = $readerID '
            'ORDER BY b.title',
            readsFrom: {
              db.book,
              db.bookRead,
            })
        .watch()
        .listen((row) {
          ctrl.add(row.map((data) {
            return models.Book(
                id: data.read<int>('book_id'),
                author: data.read<String>('author'),
                title: data.read<String>('title'),
                coverImage: data.read<String?>('cover_image'),
                isbn: data.read<String>('isbn'),
                dateRead: DateTime.tryParse(data.read<String>('timestamp')));
          }).toList());
        });

    return ctrl.stream;
  }

  Future<void> addBook(models.Book book) async {
    // check ISBN does not already exist
    final matchingISBNs = await (db.select(db.book)
          ..where((b) => b.isbn.equals(book.isbn)))
        .get();
    if (matchingISBNs.isNotEmpty) {
      return;
    }

    db.into(db.book).insert(
          BookCompanion(
            title: Value<String>(book.title),
            author: Value<String>(book.author),
            isbn: Value<String>(book.isbn),
            coverImage: book.coverImage != null
                ? Value<String?>(book.coverImage)
                : const Value.absent(),
          ),
        );
  }

  Future<List<models.Book>> searchBooks(String term) async {
    final orderBy = db.book.title;

    if (term.isEmpty) {
      return (db.select(db.book)
            ..orderBy([(e) => OrderingTerm(expression: orderBy)]))
          .get()
          .then((list) {
        return list.map(toBookModel).toList();
      });
    }

    final query = db.select(db.book)
      ..where((t) => t.title.contains(term) | t.author.contains(term))
      ..orderBy([(e) => OrderingTerm(expression: orderBy)]);

    return query.map(toBookModel).get();
  }

  Future<void> bookRead(models.Reader reader, models.Book book) async {
    if (reader.id == null) {
      throw ArgumentError('Reader ID is null');
    }

    if (book.id == null) {
      throw ArgumentError('Book ID is null');
    }

    db.into(db.bookRead).insert(
          BookReadCompanion.insert(
            readerId: reader.id!,
            bookId: book.id!,
            timestamp: DateTime.now().toIso8601String(),
          ),
        );
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
