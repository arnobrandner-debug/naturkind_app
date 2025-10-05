class DownloadsService {
  final Map<String, String> _items = {};

  void add(String id, String title) => _items[id] = title; // TODO: Dateien cachen
  void remove(String id) => _items.remove(id);
  Map<String, String> all() => Map.unmodifiable(_items);
}

