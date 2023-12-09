import 'dart:convert';

import 'package:a_bunch_of_books/models/models.dart';
import 'package:flutter/material.dart';

class BookRow extends StatelessWidget {
  final Book book;

  const BookRow({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: book.coverImage != null
              ? ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 100,
                    maxHeight: 100,
                  ),
                  child: Image.memory(base64Decode(book.coverImage!)))
              : Container(
                  height: 100,
                  width: 100,
                  color: Theme.of(context).shadowColor.withOpacity(0.1),
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
            ],
          ),
        )
      ],
    );
  }
}
