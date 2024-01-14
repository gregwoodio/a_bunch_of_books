import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'About',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'A Bunch of Books ',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    TextSpan(
                      text:
                          'is a companion app for the \'1000 Books by Kindergarten\' challenge to promote early childhood literacy. The goal is to simply read 1000 books to your child before starting school. Yes, repeats are allowed. ',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    TextSpan(
                      text: 'A Bunch of Books ',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    TextSpan(
                      text:
                          'helps you through this challenge by letting you create a library of books your child has read and tracks their reading progress.\n',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    TextSpan(
                      text: 'A Bunch of Books ',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    TextSpan(
                      text:
                          'is not affiliated with the 1000 Books Foundation. You can learn more about the challenge and foundation at ',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    link(context, 'https://1000booksbeforekindergarten.org/'),
                    TextSpan(
                      text:
                          'No copyright infringement is intended. This is just an app made by a software developer dad.\n',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    TextSpan(
                      text:
                          'This app uses Open Library as the source for books. Please consider supporting them as well at ',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    link(context, 'https://openlibrary.org/')
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextSpan link(BuildContext context, String url) {
    return TextSpan(
      text: '$url ',
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).primaryColorDark,
          ),
      recognizer: TapGestureRecognizer()
        ..onTap = () {
          try {
            launchUrl(Uri.parse(url));
          } catch (_) {}
        },
    );
  }
}
