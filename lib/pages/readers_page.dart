import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReadersPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: Text('Readers'),
      ),
    );
  }
}
