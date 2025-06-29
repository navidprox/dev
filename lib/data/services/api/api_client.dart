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

import 'dart:convert';
import 'dart:io';
import 'package:portfolio/utils/utils.dart';
import 'package:portfolio/data/services/api/model/model.dart';

/// Adds the `Authentication` header to a header configuration.
typedef AuthHeaderProvider = String? Function();

class ApiClient {
  ApiClient({String? host, int? port, HttpClient Function()? clientFactory})
    : _host = host ?? 'localhost',
      _port = port ?? 8080,
      _clientFactory = clientFactory ?? HttpClient.new;

  final String _host;
  final int _port;
  final HttpClient Function() _clientFactory;

  AuthHeaderProvider? _authHeaderProvider;

  set authHeaderProvider(AuthHeaderProvider authHeaderProvider) {
    _authHeaderProvider = authHeaderProvider;
  }

  Future<void> _authHeader(HttpHeaders headers) async {
    final header = _authHeaderProvider?.call();
    if (header != null) {
      headers.add(HttpHeaders.authorizationHeader, header);
    }
  }

  Future<Result<UserApiModel>> getUser() async {
    final client = _clientFactory();
    try {
      final request = await client.get(_host, _port, '/user');
      await _authHeader(request.headers);
      final response = await request.close();
      if (response.statusCode == 200) {
        final stringData = await response.transform(utf8.decoder).join();
        final user = UserApiModel.fromJson(jsonDecode(stringData));
        return Result.ok(user);
      } else {
        return Result.error(HttpException("Invalid response"));
      }
    } on Exception catch (error) {
      return Result.error(error);
    } finally {
      client.close();
    }
  }

  Future<Result<void>> deleteBooking(int id) async {
    final client = _clientFactory();
    try {
      final request = await client.delete(_host, _port, '/booking/$id');
      await _authHeader(request.headers);
      final response = await request.close();
      // Response 204 "No Content", delete was successful
      if (response.statusCode == 204) {
        return const Result.ok(null);
      } else {
        return Result.error(HttpException("Invalid response"));
      }
    } on Exception catch (error) {
      return Result.error(error);
    } finally {
      client.close();
    }
  }

  Future<Result<MessageApiModel>> sendMessage(String text) async {
    final client = _clientFactory();
    try {
      final request = await client.post(_host, _port, '/api/chat');
      await _authHeader(request.headers);
      request.write(jsonEncode({'text': text}));
      final response = await request.close();
      if (response.statusCode == 201) {
        final stringData = await response.transform(utf8.decoder).join();
        return Result.ok(MessageApiModel.fromJson(jsonDecode(stringData)));
      } else {
        return Result.error(HttpException("Invalid response"));
      }
    } on Exception catch (error) {
      return Result.error(error);
    } finally {
      client.close();
    }
  }

}
