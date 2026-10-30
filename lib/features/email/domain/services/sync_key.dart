import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';

/// 32 bytes aleatorios en hexadecimal.
String generateSyncKey([Random? random]) {
  final Random source = random ?? Random.secure();
  return <String>[
    for (int i = 0; i < 32; i++)
      source.nextInt(256).toRadixString(16).padLeft(2, '0'),
  ].join();
}

String hashSyncKey(String key) => sha256.convert(utf8.encode(key)).toString();
