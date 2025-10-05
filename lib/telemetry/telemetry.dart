import 'package:flutter/foundation.dart';

void logKidsOpen() => debugPrint('[telemetry] kids_open');
void logKidsItemOpen(String id) => debugPrint('[telemetry] kids_item_open: $id');
void logKidsStickerView() => debugPrint('[telemetry] kids_sticker_view');
// TODO: echtes Tracking nur mit Consent

