import 'dart:async';
import 'package:flutter/material.dart';
import 'app.dart';
import 'core/config/flavor_config.dart';
import 'core/dependency_injection/config/configure_injection.dart';

Future<void> runApplication(Flavor flavor) async {
  WidgetsFlutterBinding.ensureInitialized();
  FlavorConfig.initialize(flavor);
  await configureInjection();
  runApp(MyApp());
}
