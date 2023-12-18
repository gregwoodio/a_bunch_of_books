import 'package:a_bunch_of_books/services/open_library_service.dart';
import 'package:a_bunch_of_books/widgets/library_search.dart';
import 'package:flutter/material.dart';

import 'book_row.dart';

// Search OpenLibrary for books
class BookSearch extends LibrarySearch {
  BookSearch(super.ref);

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 2) {
      return const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Search term must be longer than one letter.",
            ),
          )
        ],
      );
    }

    return FutureBuilder(
      future: ref.read(openLibraryService).searchBooks(query),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final books = snapshot.data ?? [];

        return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: books.length,
          itemBuilder: (context, i) => GestureDetector(
            onTap: () => close(context, books[i]),
            child: BookRow(book: books[i]),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
