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

part of 'message_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MessageApiModel _$MessageApiModelFromJson(Map<String, dynamic> json) =>
    _MessageApiModel(
      dateTime: DateTime.parse(json['dateTime'] as String),
      text: json['text'] as String,
    );

Map<String, dynamic> _$MessageApiModelToJson(_MessageApiModel instance) =>
    <String, dynamic>{
      'dateTime': instance.dateTime.toIso8601String(),
      'text': instance.text,
    };
