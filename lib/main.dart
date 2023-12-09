import 'package:a_bunch_of_books/pages/about_page.dart';
import 'package:a_bunch_of_books/pages/app_page.dart';
import 'package:a_bunch_of_books/pages/library_page.dart';
import 'package:a_bunch_of_books/pages/readers_page.dart';
import 'package:a_bunch_of_books/widgets/book_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'A Bunch of Books',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePage();
}

class _HomePage extends ConsumerState<HomePage> {
  AppPage currentPage = AppPage.readers;

  @override
  Widget build(BuildContext context) {
    Widget body;
    switch (currentPage) {
      case AppPage.readers:
        body = ReadersPage();
        break;
      case AppPage.library:
        body = LibraryPage();
        break;
      case AppPage.about:
        body = AboutPage();
        break;
    }

    return Scaffold(
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: AppPage.values.indexOf(currentPage),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        selectedItemColor: Theme.of(context).colorScheme.inverseSurface,
        unselectedItemColor:
            Theme.of(context).colorScheme.inverseSurface.withAlpha(150),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Readers'),
          BottomNavigationBarItem(
              icon: Icon(Icons.library_books), label: 'Library'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'About'),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              print('Navigate to Readers');
              setState(() => currentPage = AppPage.readers);
              break;
            case 1:
              print('Navigate to Library');
              setState(() => currentPage = AppPage.library);
              break;
            case 2:
              print('Navigate to About');
              setState(() => currentPage = AppPage.about);
              break;
          }
        },
      ),
    );
  }
}
