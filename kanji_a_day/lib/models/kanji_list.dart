import 'dart:math';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

import '../utils/shared_preferences.dart';
import 'kanji.dart';

final _prefs = SharedPreferencesHelper();

class KanjiList {
  List<Kanji> _kanjiList = [];

  Future<void> loadKanjiList() async {
    try {
      String csvData =
          await rootBundle.loadString('assets/data/kanji_data.csv');
      List<List<dynamic>> csvTable = CsvToListConverter().convert(csvData);

      _kanjiList = csvTable
          .map((row) => Kanji(
                character: row[0],
                meaning: row[1],
                on: row[2],
                kun: row[3],
              ))
          .toList();
    } catch (e) {
      print(e);
    }
  }

  Kanji getRandomKanji(List<String> displayedKanji) {
    List<Kanji> kanjiPool = _kanjiList
        .where((kanji) => !displayedKanji.contains(kanji.character))
        .toList();
    print(displayedKanji.length);
    if (kanjiPool.isEmpty) {
      displayedKanji.clear();
    }

    kanjiPool = _kanjiList
        .where((kanji) => !displayedKanji.contains(kanji.character))
        .toList();
    return kanjiPool[Random().nextInt(kanjiPool.length)];
  }
}
