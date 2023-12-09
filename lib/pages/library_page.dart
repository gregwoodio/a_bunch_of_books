import 'package:a_bunch_of_books/dao/dao.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/models.dart';

class LibraryPage extends ConsumerWidget {
  const LibraryPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
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
