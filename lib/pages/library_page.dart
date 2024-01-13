import 'package:a_bunch_of_books/dao/dao.dart';
import 'package:a_bunch_of_books/services/open_library_service.dart';
import 'package:a_bunch_of_books/widgets/book_search.dart';
import 'package:a_bunch_of_books/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/models.dart';
import '../widgets/book_row.dart';
import '../widgets/library_search.dart';

class LibraryPage extends ConsumerWidget {
  const LibraryPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ABOBScaffold(
      actions: [
        IconButton(
          onPressed: () async {
            var book =
                await showSearch(context: context, delegate: BookSearch(ref));

            if (book == null) {
              return;
            }

            final confirmed =
                await confirmAddBook(context: context, book: book);
            if (!confirmed) {
              return;
            }

            await ref.read(daoProvider).addBook(book);
          },
          icon: const Icon(Icons.add),
        ),
        PopupMenuButton<String>(
          onSelected: (String result) {
            // Sort books
            // if (result == "Alphabetically") {
            //   // Sort Alphabetically
            // } else if (result == "Last Read") {
            //   // Sort by last read
            // }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: "Alphabetically",
              child: Text('Sort Alphabetically'),
            ),
            const PopupMenuItem<String>(
              value: "Last Read",
              child: Text('Sort by Last Read'),
            ),
          ],
        ),
      ],
      body: StreamBuilder<List<Book>>(
        stream: ref.read(daoProvider).getBooks(),
        builder: (BuildContext context, AsyncSnapshot<List<Book>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error!.toString()),
            );
          }

          final books = snapshot.data!;

          return ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) => BookRow(book: books[index]));
        },
      ),
    );
  }

  Future<bool> confirmAddBook({
    required BuildContext context,
    required Book book,
  }) async {
    final confirmed = await showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            content: Text('Add \'${book.title}\' to your library?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(ctx).pop(true);
                },
                child: const Text('Yes'),
              ),
            ],
          );
        });

    return confirmed;
  }
}
