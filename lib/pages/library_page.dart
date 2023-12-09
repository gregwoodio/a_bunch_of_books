import 'package:a_bunch_of_books/dao/dao.dart';
import 'package:a_bunch_of_books/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/models.dart';
import '../widgets/book_search.dart';

class LibraryPage extends ConsumerWidget {
  const LibraryPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ABOBScaffold(
      actions: [
        IconButton(
          onPressed: () {
            showSearch(context: context, delegate: BookSearch(ref));
          },
          icon: const Icon(Icons.search),
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
            itemBuilder: (context, index) {
              final book = books[index];

              return Text(book.title);
            },
          );
        },
      ),
    );
  }
}
