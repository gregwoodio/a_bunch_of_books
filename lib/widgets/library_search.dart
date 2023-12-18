import 'package:a_bunch_of_books/dao/dao.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/models.dart';
import 'book_row.dart';

// Search Books from the Books table in the database.
class LibrarySearch extends SearchDelegate<Book?> {
  final WidgetRef ref;

  LibrarySearch(this.ref);

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context);
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

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
      future: ref.read(daoProvider).searchBooks(query),
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
    return FutureBuilder(
      future: ref.read(daoProvider).searchBooks(''),
      builder: (context, snapshot) {
        final books = snapshot.data ?? [];
        return ListView.builder(
          itemCount: books.length,
          itemBuilder: (context, i) => GestureDetector(
            onTap: () => close(context, books[i]),
            child: BookRow(book: books[i]),
          ),
        );
      },
    );
  }
}
