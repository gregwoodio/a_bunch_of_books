import 'package:a_bunch_of_books/dao/dao.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/models.dart';

class BookSearch extends SearchDelegate<Book?> {
  final WidgetRef _ref;

  BookSearch(this._ref);

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

    // Add your search terms to your search query and show the results
    // Get the books from your DAO and filter them with the search query
    // For this sample, I am returning an empty Container. Replace this with actual search results.
    return FutureBuilder(
      future: _ref.read(daoProvider).searchBooks(query),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        final books = snapshot.data ?? [];

        return ListView.builder(
          itemCount: books.length,
          itemBuilder: (context, i) => Text(
            books[i].title,
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
