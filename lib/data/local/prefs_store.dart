// path: lib/data/local/prefs_store.dart
// Wrapper around SharedPreferences for app-wide flags.
import 'package:shared_preferences/shared_preferences.dart';

class PrefsStore {
  PrefsStore._(this._prefs);

  final SharedPreferences _prefs;

  static const String _firstRunKey = 'prefs_first_run';

  static Future<PrefsStore> create() async {
    final prefs = await SharedPreferences.getInstance();
    return PrefsStore._(prefs);
  }

  Future<bool> isFirstRun() async {
    return _prefs.getBool(_firstRunKey) ?? true;
  }

  Future<void> setFirstRun(bool value) async {
    await _prefs.setBool(_firstRunKey, value);
  }
}
