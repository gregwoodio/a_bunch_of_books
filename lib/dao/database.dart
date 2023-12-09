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
              isbn: '9780399250453',
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
