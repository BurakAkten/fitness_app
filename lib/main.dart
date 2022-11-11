import 'dart:async';
import 'package:fitness_app/screens/app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runZonedGuarded<Future<void>>(
    () async {
      runApp(const App());
    },
    (_, __) {},
    zoneSpecification: ZoneSpecification(print: (Zone self, ZoneDelegate parent, Zone zone, String message) {
      if (kDebugMode) {
        parent.print(zone, '${"Fitness App"} ${DateTime.now()}: $message');
      }
    }),
  );
}
