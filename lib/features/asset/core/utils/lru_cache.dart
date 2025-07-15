class LRUCache<K, V> {
  final int _maxSize;
  final Map<K, _CacheNode<K, V>> _map = {};
  _CacheNode<K, V>? _head;
  _CacheNode<K, V>? _tail;

  LRUCache(this._maxSize);

  V? get(K key) {
    final node = _map[key];
    if (node == null) return null;

    _moveToHead(node);
    return node.value;
  }

  void put(K key, V value) {
    final existingNode = _map[key];

    if (existingNode != null) {
      existingNode.value = value;
      _moveToHead(existingNode);
      return;
    }

    final newNode = _CacheNode(key, value);

    if (_map.length >= _maxSize) {
      _removeTail();
    }

    _addToHead(newNode);
    _map[key] = newNode;
  }

  bool containsKey(K key) => _map.containsKey(key);

  void clear() {
    _map.clear();
    _head = null;
    _tail = null;
  }

  void _addToHead(_CacheNode<K, V> node) {
    node.prev = null;
    node.next = _head;

    _head?.prev = node;
    _head = node;

    _tail ??= _head;
  }

  void _removeNode(_CacheNode<K, V> node) {
    if (node.prev != null) {
      node.prev!.next = node.next;
    } else {
      _head = node.next;
    }

    if (node.next != null) {
      node.next!.prev = node.prev;
    } else {
      _tail = node.prev;
    }
  }

  void _moveToHead(_CacheNode<K, V> node) {
    _removeNode(node);
    _addToHead(node);
  }

  void _removeTail() {
    if (_tail != null) {
      _map.remove(_tail!.key);
      _removeNode(_tail!);
    }
  }
}

class _CacheNode<K, V> {
  K key;
  V value;
  _CacheNode<K, V>? prev;
  _CacheNode<K, V>? next;

  _CacheNode(this.key, this.value);
}
