// path: lib/providers/app_bootstrap_provider.dart
// Handles splash bootstrap: loads persistent flags before routing.
import 'package:FlutterApp/data/local/prefs_store.dart';
import 'package:flutter/foundation.dart';

class AppBootstrapProvider extends ChangeNotifier {
  AppBootstrapProvider(this._prefsStore);

  final PrefsStore _prefsStore;

  bool _isLoading = false;
  bool _isFirstRun = true;
  String? _error;
  bool _initialized = false;

  bool get isLoading => _isLoading;
  bool get isFirstRun => _isFirstRun;
  String? get error => _error;

  Future<void> ensureInitialized() async {
    if (_initialized || _isLoading) {
      return;
    }
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _isFirstRun = await _prefsStore.isFirstRun();
      _initialized = true;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> reload() async {
    _initialized = false;
    await ensureInitialized();
  }
}

