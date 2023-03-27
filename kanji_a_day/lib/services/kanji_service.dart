import 'dart:async';
import 'dart:math';

import 'package:kanji_a_day/models/kanji.dart';
import 'package:kanji_a_day/models/kanji_list.dart';
import 'package:kanji_a_day/utils/shared_preferences.dart';

class KanjiService {
  KanjiList _kanjiList = KanjiList();
  List<String> _displayedKanji = [];

  Future<void> initialize() async {
    await _kanjiList.loadKanjiList();
    _displayedKanji = await SharedPreferencesHelper.getDisplayedKanji();
  }

  Future<Kanji> getRandomKanji() async {
    Kanji kanji = _kanjiList.getRandomKanji(_displayedKanji);
    if (kanji.character != 'No more kanji!') {
      await SharedPreferencesHelper.addDisplayedKanji(kanji.character);
      _displayedKanji.add(kanji.character);
    }
    return kanji;
  }
}
