import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';

class OpenLibraryService {
  final String coverSearchUrl = 'https://covers.openlibrary.org/b/isbn/';

  Future<List<Book>> searchBooks(String searchTerm) async {
    if (searchTerm.isEmpty) {
      return [];
    }

    final uri = Uri.https(
        'openlibrary.org', 'search.json', {'q': searchTerm, 'lang': 'en'});

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      // TODO: Error handling
      print(response.body);
      return [];
    }

    try {
      final json = jsonDecode(response.body);
      final docs = json['docs'] as List<dynamic>;

      // TODO: rate limit or lazy load covers
      final functions = docs.map((elem) => () async {
            var book = Book.fromMap(elem);

            if (elem['cover_i'] != null) {
              final cover = await searchCovers(elem['cover_i'].toString());
              if (cover != null) {
                book = book.copyWith(coverImage: cover);
              }
            }

            return book;
          }());

      final books = await Future.wait<Book>(functions);
      return books;
    } catch (error) {
      print(error);
      return [];
    }
  }

  Future<String?> searchCovers(
    String coverID, {
    String size = 'M',
  }) async {
    if (coverID.isEmpty) {
      return null;
    }

    final uri = Uri.https('covers.openlibrary.org', 'b/id/$coverID-$size.jpg');

    final response = await http.get(uri);

    if (response == null || response.statusCode != 200) {
      // TODO: Error handling
      print(response.body);
      return null;
    }

    final bytes = response.bodyBytes;
    return base64Encode(bytes);
  }
}

final openLibraryService = Provider.autoDispose((ref) => OpenLibraryService());
