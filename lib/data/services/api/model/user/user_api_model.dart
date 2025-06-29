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

part 'user_api_model.freezed.dart';
part 'user_api_model.g.dart';

@freezed
abstract class UserApiModel with _$UserApiModel {
  const factory UserApiModel({
    /// The user's ID.
    required String id,

    /// The user's name.
    required String name,

    /// The user's email.
    required String email,

    /// The user's picture URL.
    required String picture,
  }) = _UserApiModel;

  factory UserApiModel.fromJson(Map<String, Object?> json) =>
      _$UserApiModelFromJson(json);
}
