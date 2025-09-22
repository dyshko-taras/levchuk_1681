// path: lib/providers/bottom_nav_provider.dart
// Manages bottom navigation index and history stack for shell.
import 'package:flutter/foundation.dart';

class BottomNavProvider extends ChangeNotifier {
  BottomNavProvider({int initialIndex = 0})
    : _currentIndex = initialIndex,
      _history = <int>[initialIndex];

  int _currentIndex;
  final List<int> _history;

  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    if (index == _currentIndex) return;
    _currentIndex = index;
    _history..remove(index)
    ..add(index);
    notifyListeners();
  }

  bool handleBack() {
    if (_history.length <= 1) {
      return false;
    }
    _history.removeLast();
    _currentIndex = _history.last;
    notifyListeners();
    return true;
  }

  void resetTo(int index) {
    _history
      ..clear()
      ..add(index);
    _currentIndex = index;
    notifyListeners();
  }

  List<int> get history => List<int>.unmodifiable(_history);
}
