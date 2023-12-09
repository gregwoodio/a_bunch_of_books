import 'package:flutter/material.dart';

class ABOBScaffold extends StatelessWidget {
  final List<Widget> actions;
  final Widget body;

  ABOBScaffold({
    super.key,
    this.actions = const [],
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('A Bunch of Books'),
        actions: actions,
      ),
      body: body,
    );
  }
}
