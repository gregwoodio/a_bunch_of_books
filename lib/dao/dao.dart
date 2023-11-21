import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'database.dart';
import '../models/models.dart' as models;

class DAO {
  final Database db;

  DAO(this.db);

  Stream<List<models.Reader>> getReaders() {
    StreamController<List<models.Reader>> ctrl =
        StreamController<List<models.Reader>>();

    db.select(db.reader).watch().listen((data) {
      ctrl.add(data.map(toModel).toList());
    });

    return ctrl.stream;
  }

  models.Reader toModel(ReaderData data) {
    return models.Reader(
      id: data.id,
      name: data.name,
      image: data.image,
    );
  }
}

final daoProvider = Provider.autoDispose((ref) => DAO(ref.read(dbProvider)));
