import 'package:tractian/features/asset/domain/entities/tree_node.dart';

class PersistentCacheService {
  static PersistentCacheService? _instance;
  static PersistentCacheService get instance =>
      _instance ??= PersistentCacheService._();

  PersistentCacheService._();

  final Map<String, List<TreeNode>> _cache = {};

  Future<void> initialize() async {}

  List<TreeNode>? getFilterCache(String key) {
    return _cache[key];
  }

  Future<void> putFilterCache(String key, List<TreeNode> data) async {
    _cache[key] = data;

    if (_cache.length > 20) {
      final firstKey = _cache.keys.first;
      _cache.remove(firstKey);
    }
  }

  bool containsKey(String key) {
    return _cache.containsKey(key);
  }

  Future<void> clearCache() async {
    _cache.clear();
  }
}
