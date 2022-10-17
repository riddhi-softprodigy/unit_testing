import 'package:audioPlayer/player/songList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SongList', () {
    testWidgets('Should not scroll with less item',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: SongList(),
      ));

      await tester.drag(find.byType(ListView), const Offset(0, -300));
      await tester.pump();

      final listTileFinder = find.byType(ListTile);
      expect(listTileFinder, findsNWidgets(5));
    });

    testWidgets('Should only show on 2 small screen',
        (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = Size(320, 350);
      await tester.pumpWidget(MaterialApp(
        home: SongList(),
      ));

      await tester.drag(find.byType(ListView), const Offset(0, -200));
      await tester.pump();

      final listTileFinder = find.byType(ListTile);
      expect(listTileFinder, findsNWidgets(1));
    });
  });
}
