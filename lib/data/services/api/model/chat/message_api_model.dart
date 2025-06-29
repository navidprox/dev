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

import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_api_model.freezed.dart';
part 'message_api_model.g.dart';

@freezed
abstract class MessageApiModel with _$MessageApiModel {
  const factory MessageApiModel({
    required DateTime dateTime,
    required String text,
  }) = _MessageApiModel;

  factory MessageApiModel.fromJson(Map<String, Object?> json) =>
      _$MessageApiModelFromJson(json);
}
