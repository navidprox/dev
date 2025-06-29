import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:portfolio/ui/ui.dart';
import 'package:provider/provider.dart';
import 'config/dependencies.dart';
import 'config/content.dart';

void main() {
  Logger.root.level = kReleaseMode ? Level.INFO : Level.ALL;

  licenseRegistry();

  runApp(
    MultiProvider(
      providers: [
        Provider<Content>(
          create: (context) => Content(),
          dispose: (context, value) => value.dispose(),
        ),
        ...providersRemote,
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfolio',
      themeMode: appThemeMode,
      darkTheme: appTheme,
      home: const HomePage(),
    );
  }
}

void licenseRegistry() {
  LicenseRegistry.addLicense(() async* {
    yield LicenseEntryWithLineBreaks(
      ['google_fonts'],
      await rootBundle.loadString('assets/licenses/ofl.txt'),
    );

    yield LicenseEntryWithLineBreaks(
      ['word_cloud'],
      await rootBundle.loadString('assets/licenses/word_cloud.txt'),
    );

    yield LicenseEntryWithLineBreaks(
      ['samples'],
      await rootBundle.loadString('assets/licenses/samples.txt'),
    );
  });
}
