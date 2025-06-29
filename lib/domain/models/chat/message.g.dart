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

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Message _$MessageFromJson(Map<String, dynamic> json) => _Message(
  dateTime: DateTime.parse(json['dateTime'] as String),
  text: json['text'] as String,
  side: $enumDecode(_$MessageSideEnumMap, json['side']),
);

Map<String, dynamic> _$MessageToJson(_Message instance) => <String, dynamic>{
  'dateTime': instance.dateTime.toIso8601String(),
  'text': instance.text,
  'side': _$MessageSideEnumMap[instance.side]!,
};

const _$MessageSideEnumMap = {
  MessageSide.user: 'user',
  MessageSide.server: 'server',
};
