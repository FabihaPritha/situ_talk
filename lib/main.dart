import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:situ_talk/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  // Initialize storage service
  // await StorageService.init();

  // // Initialize localization service
  // await LocalizationService.initialize();

  runApp(const SituTalk());
}