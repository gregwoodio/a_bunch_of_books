import 'package:a_bunch_of_books/dao/shared_db.dart';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'database.g.dart';

class Reader extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get image => text().nullable()();
}

class Book extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get author => text()();
  TextColumn get isbn => text()();
}

class BookRead extends Table {
  IntColumn get readerID => integer().references(Reader, #id)();
  IntColumn get bookID => integer().references(Book, #id)();
  TextColumn get timestamp => text()();
}

@DriftDatabase(tables: [
  Reader,
  Book,
  BookRead,
])
class Database extends _$Database {
  Database(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;
}

final dbProvider = StateProvider<Database>((ref) => constructDb());
