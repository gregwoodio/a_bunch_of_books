class Reader {
  final int? id;
  final String name;

  /// Optional image data
  final String? image;

  final int booksRead;

  Reader({
    this.id,
    required this.name,
    this.image,
    this.booksRead = 0,
  });
}

class Book {
  final int? id;
  final String title;
  final String author;
  final String? coverImage;
  final String isbn;

  Book({
    this.id,
    required this.title,
    required this.author,
    this.coverImage,
    required this.isbn,
  });

  factory Book.fromMap(dynamic json) {
    dynamic authorNames = json['author_name'];
    late String author;
    if (authorNames is List<dynamic>) {
      author = authorNames.firstOrNull?.toString() ?? 'Not found';
    } else {
      author = 'Not found 2';
    }

    late String isbn;
    dynamic isbnValues = json['isbn'];
    if (isbnValues is List<dynamic>) {
      isbn = isbnValues.firstOrNull?.toString() ?? '';
    } else if (isbnValues is String) {
      isbn = isbnValues?.toString() ?? '';
    } else {
      isbn = '';
    }

    return Book(title: json['title'], author: author, isbn: isbn);
  }

  Book copyWith({
    String? title,
    String? author,
    String? isbn,
    String? coverImage,
  }) {
    return Book(
      title: title ?? this.title,
      author: author ?? this.author,
      isbn: isbn ?? this.isbn,
      coverImage: coverImage ?? this.coverImage,
    );
  }
}

class BookRead {
  final Book book;
  final DateTime timestamp;

  BookRead({
    required this.book,
    required this.timestamp,
  });
}
