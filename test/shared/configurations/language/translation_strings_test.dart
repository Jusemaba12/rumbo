import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

Set<String> _keys(String file) =>
    (jsonDecode(File('configuration/language/$file').readAsStringSync())
            as Map<String, dynamic>)
        .keys
        .where((String key) => !key.startsWith('@'))
        .toSet();

void main() {
  test('español e inglés tienen las mismas claves', () {
    expect(_keys('app_en.arb'), _keys('app_es.arb'));
  });

  test('todas las claves se usan en lib/', () {
    final String code = <String>[
      for (final FileSystemEntity entity in Directory(
        'lib',
      ).listSync(recursive: true))
        if (entity is File &&
            entity.path.endsWith('.dart') &&
            !entity.path.contains('configurations/language/'))
          entity.readAsStringSync(),
    ].join('\n');
    expect(
      _keys('app_es.arb')
          .where((String key) => !RegExp('\\.$key\\b').hasMatch(code)),
      isEmpty,
    );
  });
}
