import 'package:flutter/material.dart';
import 'package:kanji_a_day/models/kanji.dart';
import 'package:kanji_a_day/services/kanji_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final KanjiService _kanjiService = KanjiService();
  Kanji _currentKanji = Kanji(character: '', meaning: '', on: '', kun: '');

  @override
  void initState() {
    super.initState();
    _initializeKanjiService();
  }

  Future<void> _initializeKanjiService() async {
    await _kanjiService.initialize();
    _setNextKanji();
  }

  Future<void> _setNextKanji() async {
    Kanji nextKanji = await _kanjiService.getRandomKanji();
    setState(() {
      _currentKanji = nextKanji;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kanji of the Day'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _currentKanji.character,
              style: const TextStyle(
                fontSize: 72.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24.0),
            Text(
              _currentKanji.meaning,
              style: const TextStyle(
                fontSize: 24.0,
              ),
            ),
            Text(
              _currentKanji.on,
              style: const TextStyle(
                fontSize: 24.0,
              ),
            ),
            Text(
              _currentKanji.kun,
              style: const TextStyle(
                fontSize: 24.0,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _setNextKanji,
        tooltip: 'Next Kanji',
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}
