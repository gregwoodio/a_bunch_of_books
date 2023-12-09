import 'package:a_bunch_of_books/dao/dao.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/models.dart';

class ReadersPage extends ConsumerWidget {
  late final TextEditingController newReaderController;

  ReadersPage() {
    newReaderController = TextEditingController();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Add Reader'),
              content:
                  Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Name:'),
                  TextField(
                    controller: newReaderController,
                  )
                ],
              ),
              // ),
              actions: [
                TextButton(
                  onPressed: () {
                    newReaderController.text = '';
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    final dao = ref.read(daoProvider);
                    dao.addReader(
                      Reader(
                        name: newReaderController.text,
                      ),
                    );
                    newReaderController.text = '';
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        ),
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<Reader>>(
        stream: ref.read(daoProvider).getReaders(),
        builder: (BuildContext context, AsyncSnapshot<List<Reader>> snapshot) {
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

          final readers = snapshot.data!;

          return ListView.builder(
            itemCount: readers.length,
            itemBuilder: (context, index) {
              final reader = readers[index];
              return Row(
                children: [
                  reader.image == null
                      ? Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            height: 100,
                            width: 100,
                            color: Theme.of(context).colorScheme.primary,
                            child: Center(
                              child: Text(
                                reader.name.substring(0, 1),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inversePrimary,
                                    ),
                              ),
                            ),
                          ),
                        )
                      : Container(), // TODO, replace with Image.memory
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(reader.name),
                          LinearProgressIndicator(
                            value: reader.booksRead / 1000,
                          ),
                          Text(
                            '${reader.booksRead} of 1000 Read',
                            textAlign: TextAlign.right,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: TextButton(
                                    onPressed: () {},
                                    child: const Text('Finished a Book'),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: TextButton(
                                    onPressed: () {},
                                    child: const Text('Reading list'),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
