import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StickerStore extends ChangeNotifier {
  final Set<int> _unlocked = {};

  bool isUnlocked(int id) => _unlocked.contains(id);
  void unlock(int id) {
    _unlocked.add(id);
    notifyListeners();
  }

  // TODO: Persistenz (SharedPreferences/Hive)
}

final stickerStoreProvider = ChangeNotifierProvider<StickerStore>((ref) => StickerStore());

