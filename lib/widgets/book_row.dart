import 'dart:convert';

import 'package:a_bunch_of_books/dao/dao.dart';
import 'package:a_bunch_of_books/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class BookRow extends ConsumerWidget {
  final Book book;

  const BookRow({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onLongPress: () async {
        final confirmed = await showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                content: Text(
                    'Do you want to remove \'${book.title}\' from your library? This could affect challenge progress for multiple readers.'),
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

        if (!confirmed) {
          return;
        }

        await ref.read(daoProvider).deleteBook(book);
      },
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 100,
                maxHeight: 100,
                minWidth: 100,
                minHeight: 100,
              ),
              child: book.coverImage != null
                  ? Image.memory(base64Decode(book.coverImage!))
                  : Container(
                      height: 100,
                      width: 100,
                      color: Theme.of(context).shadowColor.withOpacity(0.1),
                    ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  book.title,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text('by ${book.author}'),
                if (book.dateRead != null)
                  Text('Read on ${DateFormat.yMMMd().format(book.dateRead!)}')
              ],
            ),
          )
        ],
      ),
    );
  }
}
