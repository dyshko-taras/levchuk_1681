// path: lib/main.dart
// Minimal entrypoint that runs the App widget.
import 'package:FlutterApp/app.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}
