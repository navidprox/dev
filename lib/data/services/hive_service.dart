/*
 *  This file is part of the Portfolio project,
 *  licensed under the MIT License.
 *  Copyright (c) 2025 Navid
 *
 *  This file contains code derived from the Flutter samples project,
 *  licensed under the 3-Clause BSD License.
 *  https://github.com/flutter/samples
 *  Copyright (c) 2024 The Flutter team
 *  See THIRD-PARTY-LICENSES.md for the full license text.
 */

import 'dart:math';
import 'package:collection/collection.dart';
import 'package:hive/hive.dart';
import 'package:logging/logging.dart';
import 'package:portfolio/domain/models.dart';

class HiveService {
  final _log = Logger('HiveService');

  Box? _box;

  Future<Box> getBox() async => (_box ??= await Hive.openBox(
    'messages',
    encryptionCipher: HiveAesCipher(key),
    path: './',
  ));

  static const key = [
    193, 158, 248, 68, 106, 41, 152, 40, //
    113, 109, 50, 75, 85, 158, 207, 203, //
    182, 55, 175, 8, 87, 64, 140, 186, //
    112, 47, 22, 141, 147, 78, 95, 172,
  ];

  Future<({int? firstKey})> addNewMessages(List<Message> messages) async {
    final box = await getBox();
    final int lastKey = (box.keys.lastOrNull as int?) ?? -1;
    await box.putAll(
      Map<int, Map<String, dynamic>>.fromEntries(
        messages.mapIndexed(
          (index, m) => MapEntry<int, Map<String, dynamic>>(
            lastKey + index + 1,
            m.toJson(),
          ),
        ),
      ),
    );
    _log.finer('Messages saved');
    return (firstKey: lastKey + 1);
  }

  // Future removeMessage() {};

  Future<({Iterable<Message> messages, int? firstKey})> fetchLatestMessages({
    int? endKeyExclusive,
    int count = 20,
  }) async {
    const empty = (messages: <Message>[], firstKey: null);

    if (count <= 0) return empty;

    final box = await getBox();

    if (box.isEmpty) return empty;

    final List<int> revKeys = List<int>.from(box.keys.toList().reversed);

    final int? endExclusiveKeyIndex = endKeyExclusive == null ? null : revKeys.indexOf(endKeyExclusive);

    if (endExclusiveKeyIndex == -1) throw StateError('Message not found');

    final int startKeyInclusive = revKeys[min(revKeys.length - 1, (endExclusiveKeyIndex ?? -1) + count)];
    if (startKeyInclusive == endKeyExclusive) return empty;

    final endKeyInclusive = revKeys[min(revKeys.length - 1, (endExclusiveKeyIndex ?? -1) + 1)];
    if (endKeyInclusive == endKeyExclusive) return empty;

    _log.finer('Messages fetched');

    return (
      messages: box
          .valuesBetween(startKey: startKeyInclusive, endKey: endKeyInclusive)
          .map((e) => Message.fromJson(Map.from(e))),
      firstKey: startKeyInclusive,
    );
  }

  void dispose() {
    _box?.close();
  }
}
