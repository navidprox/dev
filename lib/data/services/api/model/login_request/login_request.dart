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

part 'login_request.freezed.dart';

part 'login_request.g.dart';

/// Simple data class to hold login request data.
@freezed
abstract class LoginRequest with _$LoginRequest {
  const factory LoginRequest({
    /// Email address.
    required String email,

    /// Plain text password.
    required String password,
  }) = _LoginRequest;

  factory LoginRequest.fromJson(Map<String, Object?> json) =>
      _$LoginRequestFromJson(json);
}
