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

part 'login_response.freezed.dart';

part 'login_response.g.dart';

/// LoginResponse model.
@freezed
abstract class LoginResponse with _$LoginResponse {
  const factory LoginResponse({
    /// The token to be used for authentication.
    required String token,

    /// The user id.
    required String userId,
  }) = _LoginResponse;

  factory LoginResponse.fromJson(Map<String, Object?> json) =>
      _$LoginResponseFromJson(json);
}
