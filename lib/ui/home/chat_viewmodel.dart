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

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:portfolio/data/repositories.dart';
import 'package:portfolio/utils/utils.dart';
import 'package:portfolio/domain/models.dart';

class ChatViewModel extends ChangeNotifier with ActionContext {
  ChatViewModel({
    required ChatRepository chatRepository,
  }) : _chatRepository = chatRepository {
    _chatRepository.connectStream().listen((message) {
      _messages = [
        ..._messages,
        message,
      ];
      notifyListeners();
    });
    sendMessage = Action(this, _sendMessage);
    loadMorePassMessages = Action(this, _loadMorePastMessages);
  }

  final _log = Logger('ChatViewModel');

  final ChatRepository _chatRepository;

  Iterable<Message> _messages = [];

  Iterable<Message> get messages => _messages;

  late final Action<String, Result<Message>> sendMessage;

  late final Action<int, Result<void>> loadMorePassMessages;

  @override
  Future<bool> canRun(Action action) async {
    if (action == sendMessage) {
      if (runningActions.contains(action)) return false;

      /// Null means history not fetched
      if (_endKeyExclusive == null) {
        /// Wait for loading initial past messages
        if (runningActions.contains(loadMorePassMessages)) {
          await loadMorePassMessages.currentResult;
        } else {
          return false;
        }
      }

      return true;
    }

    if (action == loadMorePassMessages) return _endKeyExclusive != -1 && !runningActions.contains(action);

    throw UnimplementedError();
  }

  /// -1 means ended
  int? _endKeyExclusive;

  Future<Result<void>> _loadMorePastMessages(int count) async {
    try {
      final result = await _chatRepository.loadMorePastMessages(_endKeyExclusive, count);
      _endKeyExclusive = result.firstKey ?? -1;
      _log.fine('Messages loaded');
      return Result.ok(null);
    } catch (e) {
      _log.warning('Failed to load messages', e);
      return Result.error(e);
    }
  }

  Future<Result<Message>> _sendMessage(String text) async {
    try {
      final result = await _chatRepository.sendMessage(text);
      _log.fine('Message sent ${result.dateTime}');
      return Result.ok(result);
    } catch (e) {
      _log.warning('Failed to send message: $text');
      return Result.error(e);
    }
  }

  @override
  void dispose() {
    _chatRepository.disconnectStream();
    super.dispose();
  }
}
