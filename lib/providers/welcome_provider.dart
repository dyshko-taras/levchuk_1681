// path: lib/providers/welcome_provider.dart
// Controls welcome/onboarding screen actions.
import 'dart:developer';

import 'package:FlutterApp/data/local/prefs_store.dart';
import 'package:flutter/foundation.dart';

class WelcomeProvider extends ChangeNotifier {
  WelcomeProvider(this._prefsStore);

  final PrefsStore _prefsStore;

  bool _isSubmitting = false;
  String? _error;
  bool? _isFirstRun;

  bool get isSubmitting => _isSubmitting;
  String? get error => _error;
  bool get isFirstRun => _isFirstRun ?? true;

  Future<void> readFirstRunFlag() async {
    try {
      _isFirstRun = await _prefsStore.isFirstRun();
      log('welcome_shown', name: 'analytics');
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
  }

  Future<bool> completeOnboarding() async {
    if (_isSubmitting) return false;
    _isSubmitting = true;
    _error = null;
    notifyListeners();
    try {
      await _prefsStore.setFirstRun(false);
      _isFirstRun = false;
      log('click_get_started', name: 'analytics');
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }
  }
}
