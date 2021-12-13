import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'di/injection.dart';
import 'navigation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setInjections();

  runZonedGuarded(() {
    runApp(const NavigationApp());
  }, (error, stackTrace) {
    log(error.toString(), name: 'error', stackTrace: stackTrace);
  });
}
