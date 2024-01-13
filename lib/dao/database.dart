import 'package:a_bunch_of_books/dao/shared_db.dart';
import 'package:collection/collection.dart';
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
  TextColumn get coverImage => text().nullable()();
  TextColumn get isbn => text()();
}

class BookRead extends Table {
  IntColumn get readerId => integer().references(Reader, #id)();
  IntColumn get bookId => integer().references(Book, #id)();
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

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();

        // dummy data
        await m.database.batch((batch) async {
          batch.insert(
            reader,
            ReaderCompanion.insert(
              id: const Value<int>(1),
              name: 'Teddy Ruxpin',
            ),
          );

          final books = [
            BookCompanion.insert(
              title: 'The Very Hungry Caterpillar (Storytime Giants)',
              author: 'Eric Carle',
              isbn: '9784032371109',
              coverImage: const Value<String>(
                  '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'),
            ),
          ]
              .mapIndexed(
                (i, book) => BookCompanion.insert(
                  id: Value<int>(i),
                  title: book.title.value,
                  author: book.author.value,
                  isbn: book.isbn.value,
                  coverImage: book.coverImage,
                ),
              )
              .toList();

          batch.insertAll(
            book,
            books,
          );

          batch.insertAll(
              bookRead,
              List.generate(
                books.length,
                (index) => BookReadCompanion.insert(
                  bookId: books[index].id.value,
                  readerId: 1,
                  timestamp: DateTime.now().toIso8601String(),
                ),
              ));
        });
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // if (from < 2) {
        //   // we added the dueDate property in the change from version 1 to
        //   // version 2
        //   await m.addColumn(todos, todos.dueDate);
        // }
        // if (from < 3) {
        //   // we added the priority property in the change from version 1 or 2
        //   // to version 3
        //   await m.addColumn(todos, todos.priority);
        // }
      },
    );
  }
}

final dbProvider = StateProvider<Database>((ref) => constructDb());
