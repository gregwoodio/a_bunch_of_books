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
      return (json['docs'] as List<dynamic>).map<Book>(Book.fromMap).toList();
    } catch (error) {
      print(error);
      return [];
    }
  }

  Future<String?> searchCovers(
    String isbn, {
    String size = 'M',
  }) async {
    if (isbn.isEmpty) {
      return null;
    }

    final uri = Uri.https('covers.openlibrary.org', 'b/isbn/$isbn-$size.jpg');

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
