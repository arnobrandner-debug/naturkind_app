import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePrefs {
  String? name;
  List<String> interests = const [];
}

final profilePrefsProvider = Provider<ProfilePrefs>((ref) => ProfilePrefs());
