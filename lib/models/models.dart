class Reader {
  final int? id;
  final String name;

  /// Optional image data
  final String? image;

  Reader({
    this.id,
    required this.name,
    this.image,
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
}

class BookRead {
  final Book book;
  final DateTime timestamp;

  BookRead({
    required this.book,
    required this.timestamp,
  });
}
