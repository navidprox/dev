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

import 'package:portfolio/data/repositories/auth/auth_repository_remote.dart';
import 'package:portfolio/data/repositories/chat/chat_repository_local.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:portfolio/data/services.dart';
import 'package:portfolio/data/repositories.dart';

/// Shared providers for all configurations.
List<SingleChildWidget> _sharedProviders = [];

/// Configure dependencies for remote data.
/// This dependency list uses repositories that connect to a remote server.
List<SingleChildWidget> get providersRemote {
  return [
    Provider(create: (context) => AuthApiClient()),
    Provider(create: (context) => ApiClient()),
    Provider(create: (context) => SharedPreferencesService()),
    Provider(create: (context) => HiveService()),
    ChangeNotifierProvider(
      create: (context) =>
          AuthRepositoryRemote(
                authApiClient: context.read(),
                apiClient: context.read(),
                sharedPreferencesService: context.read(),
              )
              as AuthRepository,
    ),
    Provider(
      create: (context) =>
          ChatRepositoryLocal(
                hiveService: context.read(),
              )
              as ChatRepository,
    ),
    ..._sharedProviders,
  ];
}
