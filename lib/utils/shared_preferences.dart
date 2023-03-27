import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const _keyDisplayedKanji = 'displayed_kanji';

  static Future<List<String>> getDisplayedKanji() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_keyDisplayedKanji) ?? [];
  }

  static Future<void> addDisplayedKanji(String kanji) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> displayedKanji = await getDisplayedKanji();
    displayedKanji.add(kanji);
    await prefs.setStringList(_keyDisplayedKanji, displayedKanji);
  }
}
