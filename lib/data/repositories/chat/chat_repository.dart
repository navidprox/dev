
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

import 'package:portfolio/domain/models.dart';

abstract class ChatRepository {
  Future<Message> sendMessage(String text);

  Stream<Message> connectStream();

  Future<({int? firstKey})> loadMorePastMessages([int? endKeyExclusive, int count = 20]);

  Future<void> disconnectStream();
}
