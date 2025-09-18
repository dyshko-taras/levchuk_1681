// path: lib/providers/welcome_provider.dart
// Controls welcome/onboarding screen actions.
import 'package:FlutterApp/data/local/prefs_store.dart';
import 'package:flutter/foundation.dart';

class WelcomeProvider extends ChangeNotifier {
  WelcomeProvider(this._prefsStore);

  final PrefsStore _prefsStore;

  bool _isSubmitting = false;
  String? _error;

  bool get isSubmitting => _isSubmitting;
  String? get error => _error;

  Future<bool> completeOnboarding() async {
    if (_isSubmitting) return false;
    _isSubmitting = true;
    _error = null;
    notifyListeners();
    try {
      await _prefsStore.setFirstRun(false);
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
