import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../models/kanji.dart';
import '../services/kanji_service.dart';
import '../utils/notifications.dart';

class KanjiWidget extends StatelessWidget {
  final Future<Kanji> kanjiFuture;

  const KanjiWidget({Key? key, required this.kanjiFuture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Kanji>(
      future: kanjiFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final kanji = snapshot.data!;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                kanji.character,
                style: TextStyle(fontSize: 72),
              ),
              SizedBox(height: 16),
              Text(
                kanji.meaning,
                style: TextStyle(fontSize: 24),
              ),
              ElevatedButton(
                onPressed: () async {
                  final kanjiService = KanjiService();
                  final nextKanji = await kanjiService.getRandomKanji();
                  final notificationId =
                      DateTime.now().millisecondsSinceEpoch ~/ 1000;
                  final notificationTime =
                      tz.TZDateTime.now(tz.local).add(Duration(seconds: 5));
                  scheduleKanjiNotification(
                    FlutterLocalNotificationsPlugin(),
                    notificationId,
                    nextKanji.character,
                    nextKanji.meaning,
                    notificationTime,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            'Notification scheduled for ${notificationTime.toLocal()}')),
                  );
                },
                child: Text('Schedule Notification'),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
