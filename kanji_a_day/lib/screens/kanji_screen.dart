import 'package:flutter/material.dart';
import 'package:kanji_a_day/models/kanji.dart';

class KanjiScreen extends StatelessWidget {
  final Kanji kanji;

  const KanjiScreen({super.key, required this.kanji});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kanji Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              kanji.character,
              style: const TextStyle(
                fontSize: 72.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              kanji.meaning,
              style: const TextStyle(
                fontSize: 24.0,
              ),
            ),
            Text(
              kanji.on,
              style: const TextStyle(
                fontSize: 24.0,
              ),
            ),
            Text(
              kanji.kun,
              style: const TextStyle(
                fontSize: 24.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
