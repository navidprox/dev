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

import 'dart:async';

import 'package:portfolio/domain/models.dart';
import 'package:portfolio/utils/utils.dart';
import 'chat_repository.dart';
import 'package:portfolio/data/services.dart';
import 'package:portfolio/domain/models/chat/message.dart';
import 'package:portfolio/data/services/api/model/model.dart';

class ChatRepositoryLocal implements ChatRepository {
  ChatRepositoryLocal({
    required HiveService hiveService,
  }) : _hiveService = hiveService;

  final HiveService _hiveService;

  StreamController<Message>? _streamController;
  Stream<Message>? _stream;

  @override
  Future<Message> sendMessage(String text) async {
    late final userMessage = Message(
      text: text,
      dateTime: DateTime.now(),
      side: MessageSide.user,
    );

    final response = await Future.delayed(
      const Duration(milliseconds: 500),
      () => Result.ok(MessageApiModel(dateTime: DateTime.now(), text: "Sorry, bot is out of service now!")),
    );

    switch (response) {
      case Ok<MessageApiModel>():
        _streamController?.add(userMessage);
        _hiveService.addNewMessages([userMessage]);

        final serverMessage = Message(
          text: response.value.text,
          dateTime: response.value.dateTime,
          side: MessageSide.server,
        );

        _streamController?.add(serverMessage);
        _hiveService.addNewMessages([serverMessage]);

        return serverMessage;
      case Error<MessageApiModel>():
        throw response.error;
    }
  }

  @override
  Stream<Message> connectStream() {
    if (_stream == null) {
      _streamController = StreamController();
      _stream = _streamController!.stream.asBroadcastStream();
    }
    return _stream!;
  }

  @override
  Future<({int? firstKey})> loadMorePastMessages([int? endKeyExclusive, int count = 20]) async {
    final result = await _hiveService.fetchLatestMessages(endKeyExclusive: endKeyExclusive, count: count);
    await _streamController!.addStream(Stream.fromIterable(result.messages));
    return (firstKey: result.firstKey);
  }

  @override
  Future<Result<void>> disconnectStream() async {
    await _streamController?.close();
    return const Result.ok(null);
  }
}
