// path: lib/data/repositories/_cache.dart
// Lightweight in-memory cache with optional TTL.
import 'dart:collection';

typedef Clock = DateTime Function();

class CacheEntry<V> {
  CacheEntry(this.value, this.insertedAt);
  final V value;
  final DateTime insertedAt;
}

class SimpleCache<K, V> {
  SimpleCache({this.ttl, Clock? clock}) : _clock = clock ?? DateTime.now;

  final Duration? ttl;
  final Clock _clock;
  final _map = HashMap<K, CacheEntry<V>>();

  V? get(K key) {
    final e = _map[key];
    if (e == null) return null;
    if (ttl != null && _clock().difference(e.insertedAt) > ttl!) {
      _map.remove(key);
      return null;
    }
    return e.value;
    // Note: No LRU eviction needed per scale; add if PRD requires.
  }

  void set(K key, V value) {
    _map[key] = CacheEntry<V>(value, _clock());
  }

  void invalidate(K key) => _map.remove(key);
  void clear() => _map.clear();
}
