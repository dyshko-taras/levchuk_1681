// path: lib/data/models/base_equatable.dart
import 'package:equatable/equatable.dart';

/// Base class for all app models/value objects using Equatable.
/// Extend this for consistent ==/hashCode and debug output across models.
/// Concrete models should override [props] and implement fromJson/toJson as needed.
abstract class EquatableModel extends Equatable {
  const EquatableModel();

  /// Pretty debug print for logs.
  @override
  String toString() => runtimeType.toString();
}
