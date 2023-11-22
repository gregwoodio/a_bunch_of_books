// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ReaderTable extends Reader with TableInfo<$ReaderTable, ReaderData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReaderTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
      'image', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, name, image];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reader';
  @override
  VerificationContext validateIntegrity(Insertable<ReaderData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image']!, _imageMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReaderData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReaderData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      image: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image']),
    );
  }

  @override
  $ReaderTable createAlias(String alias) {
    return $ReaderTable(attachedDatabase, alias);
  }
}

class ReaderData extends DataClass implements Insertable<ReaderData> {
  final int id;
  final String name;
  final String? image;
  const ReaderData({required this.id, required this.name, this.image});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || image != null) {
      map['image'] = Variable<String>(image);
    }
    return map;
  }

  ReaderCompanion toCompanion(bool nullToAbsent) {
    return ReaderCompanion(
      id: Value(id),
      name: Value(name),
      image:
          image == null && nullToAbsent ? const Value.absent() : Value(image),
    );
  }

  factory ReaderData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReaderData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      image: serializer.fromJson<String?>(json['image']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'image': serializer.toJson<String?>(image),
    };
  }

  ReaderData copyWith(
          {int? id,
          String? name,
          Value<String?> image = const Value.absent()}) =>
      ReaderData(
        id: id ?? this.id,
        name: name ?? this.name,
        image: image.present ? image.value : this.image,
      );
  @override
  String toString() {
    return (StringBuffer('ReaderData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('image: $image')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, image);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReaderData &&
          other.id == this.id &&
          other.name == this.name &&
          other.image == this.image);
}

class ReaderCompanion extends UpdateCompanion<ReaderData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> image;
  const ReaderCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.image = const Value.absent(),
  });
  ReaderCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.image = const Value.absent(),
  }) : name = Value(name);
  static Insertable<ReaderData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? image,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (image != null) 'image': image,
    });
  }

  ReaderCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<String?>? image}) {
    return ReaderCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReaderCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('image: $image')
          ..write(')'))
        .toString();
  }
}

class $BookTable extends Book with TableInfo<$BookTable, BookData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BookTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
      'author', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _coverImageMeta =
      const VerificationMeta('coverImage');
  @override
  late final GeneratedColumn<String> coverImage = GeneratedColumn<String>(
      'cover_image', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isbnMeta = const VerificationMeta('isbn');
  @override
  late final GeneratedColumn<String> isbn = GeneratedColumn<String>(
      'isbn', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, title, author, coverImage, isbn];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'book';
  @override
  VerificationContext validateIntegrity(Insertable<BookData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('author')) {
      context.handle(_authorMeta,
          author.isAcceptableOrUnknown(data['author']!, _authorMeta));
    } else if (isInserting) {
      context.missing(_authorMeta);
    }
    if (data.containsKey('cover_image')) {
      context.handle(
          _coverImageMeta,
          coverImage.isAcceptableOrUnknown(
              data['cover_image']!, _coverImageMeta));
    }
    if (data.containsKey('isbn')) {
      context.handle(
          _isbnMeta, isbn.isAcceptableOrUnknown(data['isbn']!, _isbnMeta));
    } else if (isInserting) {
      context.missing(_isbnMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BookData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BookData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      author: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}author'])!,
      coverImage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cover_image']),
      isbn: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}isbn'])!,
    );
  }

  @override
  $BookTable createAlias(String alias) {
    return $BookTable(attachedDatabase, alias);
  }
}

class BookData extends DataClass implements Insertable<BookData> {
  final int id;
  final String title;
  final String author;
  final String? coverImage;
  final String isbn;
  const BookData(
      {required this.id,
      required this.title,
      required this.author,
      this.coverImage,
      required this.isbn});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['author'] = Variable<String>(author);
    if (!nullToAbsent || coverImage != null) {
      map['cover_image'] = Variable<String>(coverImage);
    }
    map['isbn'] = Variable<String>(isbn);
    return map;
  }

  BookCompanion toCompanion(bool nullToAbsent) {
    return BookCompanion(
      id: Value(id),
      title: Value(title),
      author: Value(author),
      coverImage: coverImage == null && nullToAbsent
          ? const Value.absent()
          : Value(coverImage),
      isbn: Value(isbn),
    );
  }

  factory BookData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BookData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      author: serializer.fromJson<String>(json['author']),
      coverImage: serializer.fromJson<String?>(json['coverImage']),
      isbn: serializer.fromJson<String>(json['isbn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'author': serializer.toJson<String>(author),
      'coverImage': serializer.toJson<String?>(coverImage),
      'isbn': serializer.toJson<String>(isbn),
    };
  }

  BookData copyWith(
          {int? id,
          String? title,
          String? author,
          Value<String?> coverImage = const Value.absent(),
          String? isbn}) =>
      BookData(
        id: id ?? this.id,
        title: title ?? this.title,
        author: author ?? this.author,
        coverImage: coverImage.present ? coverImage.value : this.coverImage,
        isbn: isbn ?? this.isbn,
      );
  @override
  String toString() {
    return (StringBuffer('BookData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('author: $author, ')
          ..write('coverImage: $coverImage, ')
          ..write('isbn: $isbn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, author, coverImage, isbn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BookData &&
          other.id == this.id &&
          other.title == this.title &&
          other.author == this.author &&
          other.coverImage == this.coverImage &&
          other.isbn == this.isbn);
}

class BookCompanion extends UpdateCompanion<BookData> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> author;
  final Value<String?> coverImage;
  final Value<String> isbn;
  const BookCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.author = const Value.absent(),
    this.coverImage = const Value.absent(),
    this.isbn = const Value.absent(),
  });
  BookCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String author,
    this.coverImage = const Value.absent(),
    required String isbn,
  })  : title = Value(title),
        author = Value(author),
        isbn = Value(isbn);
  static Insertable<BookData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? author,
    Expression<String>? coverImage,
    Expression<String>? isbn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (author != null) 'author': author,
      if (coverImage != null) 'cover_image': coverImage,
      if (isbn != null) 'isbn': isbn,
    });
  }

  BookCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? author,
      Value<String?>? coverImage,
      Value<String>? isbn}) {
    return BookCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      coverImage: coverImage ?? this.coverImage,
      isbn: isbn ?? this.isbn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (coverImage.present) {
      map['cover_image'] = Variable<String>(coverImage.value);
    }
    if (isbn.present) {
      map['isbn'] = Variable<String>(isbn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BookCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('author: $author, ')
          ..write('coverImage: $coverImage, ')
          ..write('isbn: $isbn')
          ..write(')'))
        .toString();
  }
}

class $BookReadTable extends BookRead
    with TableInfo<$BookReadTable, BookReadData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BookReadTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _readerIDMeta =
      const VerificationMeta('readerID');
  @override
  late final GeneratedColumn<int> readerID = GeneratedColumn<int>(
      'reader_i_d', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES reader (id)'));
  static const VerificationMeta _bookIDMeta = const VerificationMeta('bookID');
  @override
  late final GeneratedColumn<int> bookID = GeneratedColumn<int>(
      'book_i_d', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES book (id)'));
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<String> timestamp = GeneratedColumn<String>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [readerID, bookID, timestamp];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'book_read';
  @override
  VerificationContext validateIntegrity(Insertable<BookReadData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('reader_i_d')) {
      context.handle(_readerIDMeta,
          readerID.isAcceptableOrUnknown(data['reader_i_d']!, _readerIDMeta));
    } else if (isInserting) {
      context.missing(_readerIDMeta);
    }
    if (data.containsKey('book_i_d')) {
      context.handle(_bookIDMeta,
          bookID.isAcceptableOrUnknown(data['book_i_d']!, _bookIDMeta));
    } else if (isInserting) {
      context.missing(_bookIDMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  BookReadData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BookReadData(
      readerID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}reader_i_d'])!,
      bookID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}book_i_d'])!,
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}timestamp'])!,
    );
  }

  @override
  $BookReadTable createAlias(String alias) {
    return $BookReadTable(attachedDatabase, alias);
  }
}

class BookReadData extends DataClass implements Insertable<BookReadData> {
  final int readerID;
  final int bookID;
  final String timestamp;
  const BookReadData(
      {required this.readerID, required this.bookID, required this.timestamp});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['reader_i_d'] = Variable<int>(readerID);
    map['book_i_d'] = Variable<int>(bookID);
    map['timestamp'] = Variable<String>(timestamp);
    return map;
  }

  BookReadCompanion toCompanion(bool nullToAbsent) {
    return BookReadCompanion(
      readerID: Value(readerID),
      bookID: Value(bookID),
      timestamp: Value(timestamp),
    );
  }

  factory BookReadData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BookReadData(
      readerID: serializer.fromJson<int>(json['readerID']),
      bookID: serializer.fromJson<int>(json['bookID']),
      timestamp: serializer.fromJson<String>(json['timestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'readerID': serializer.toJson<int>(readerID),
      'bookID': serializer.toJson<int>(bookID),
      'timestamp': serializer.toJson<String>(timestamp),
    };
  }

  BookReadData copyWith({int? readerID, int? bookID, String? timestamp}) =>
      BookReadData(
        readerID: readerID ?? this.readerID,
        bookID: bookID ?? this.bookID,
        timestamp: timestamp ?? this.timestamp,
      );
  @override
  String toString() {
    return (StringBuffer('BookReadData(')
          ..write('readerID: $readerID, ')
          ..write('bookID: $bookID, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(readerID, bookID, timestamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BookReadData &&
          other.readerID == this.readerID &&
          other.bookID == this.bookID &&
          other.timestamp == this.timestamp);
}

class BookReadCompanion extends UpdateCompanion<BookReadData> {
  final Value<int> readerID;
  final Value<int> bookID;
  final Value<String> timestamp;
  final Value<int> rowid;
  const BookReadCompanion({
    this.readerID = const Value.absent(),
    this.bookID = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BookReadCompanion.insert({
    required int readerID,
    required int bookID,
    required String timestamp,
    this.rowid = const Value.absent(),
  })  : readerID = Value(readerID),
        bookID = Value(bookID),
        timestamp = Value(timestamp);
  static Insertable<BookReadData> custom({
    Expression<int>? readerID,
    Expression<int>? bookID,
    Expression<String>? timestamp,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (readerID != null) 'reader_i_d': readerID,
      if (bookID != null) 'book_i_d': bookID,
      if (timestamp != null) 'timestamp': timestamp,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BookReadCompanion copyWith(
      {Value<int>? readerID,
      Value<int>? bookID,
      Value<String>? timestamp,
      Value<int>? rowid}) {
    return BookReadCompanion(
      readerID: readerID ?? this.readerID,
      bookID: bookID ?? this.bookID,
      timestamp: timestamp ?? this.timestamp,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (readerID.present) {
      map['reader_i_d'] = Variable<int>(readerID.value);
    }
    if (bookID.present) {
      map['book_i_d'] = Variable<int>(bookID.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<String>(timestamp.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BookReadCompanion(')
          ..write('readerID: $readerID, ')
          ..write('bookID: $bookID, ')
          ..write('timestamp: $timestamp, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  late final $ReaderTable reader = $ReaderTable(this);
  late final $BookTable book = $BookTable(this);
  late final $BookReadTable bookRead = $BookReadTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [reader, book, bookRead];
}
