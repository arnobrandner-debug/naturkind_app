import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';

import 'app_router.dart'; // dein go_router Setup
import 'firebase_options.dart'; // von FlutterFire CLI generiert
import 'core/prefs_keys.dart';

// Keys/Helper kommen jetzt zentral aus core/prefs_keys.dart

// ── Riverpod Provider
final prefsProvider =
    Provider<SharedPreferences>((ref) => throw UnimplementedError());
final consentAnalyticsProvider = StateProvider<bool>(
    (ref) => ref.watch(prefsProvider).getBool(kConsentAnalytics) ?? false);
final consentPushProvider = StateProvider<bool>(
    (ref) => ref.watch(prefsProvider).getBool(kConsentPush) ?? false);
final kidsModeProvider = StateProvider<bool>(
    (ref) => ref.watch(prefsProvider).getBool(kKidsMode) ?? false);

@pragma('vm:entry-point')
Future<void> _fcmBackgroundHandler(RemoteMessage message) async {
  // Optional: Hintergrundverarbeitung
}

Future<void> _initFirebaseIfAllowed(WidgetRef ref) async {
  final allowPush = ref.read(consentPushProvider);
  if (!allowPush) return;
  // Initialisiere Firebase mit den von FlutterFire generierten Optionen
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Android 13+: Runtime-Berechtigung für Benachrichtigungen anfragen
  if (Platform.isAndroid) {
    final status = await Permission.notification.status;
    if (!status.isGranted) {
      await Permission.notification.request();
    }
  }
  final router = ref.read(appRouterProvider);

  FirebaseMessaging.onMessageOpenedApp.listen((m) {
    final link = m.data['link'] as String?;
    if (link != null) router.go(link);
  });

  final initialMsg = await FirebaseMessaging.instance.getInitialMessage();
  if (initialMsg != null) {
    final link = initialMsg.data['link'] as String?;
    if (link != null) {
      // Router ist noch nicht gebunden → kurze Verzögerung
      Future.microtask(() => router.go(link));
    }
  }
  // funktioniert auch, wenn firebase_options.dart noch fehlt → dann später ersetzen
  FirebaseMessaging.onBackgroundMessage(_fcmBackgroundHandler);
  final fcm = FirebaseMessaging.instance;
  await fcm.requestPermission();
  // Token zu Testzwecken ausgeben (nur Debug)
  try {
    final token = await fcm.getToken();
    if (token != null) {
      // ignore: avoid_print
      print('FCM token: $token');
    }
  } catch (_) {}
  // Standard-Themen
  await fcm.subscribeToTopic('news');
  await fcm.subscribeToTopic('epaper');
}

Future<void> _initSentryIfAllowed(WidgetRef ref) async {
  final allow = ref.read(consentAnalyticsProvider);
  if (!allow) return;
  await SentryFlutter.init(
    (o) {
      o.dsn = 'YOUR_SENTRY_DSN'; // TODO: eintragen
      o.tracesSampleRate = 0.15; // moderat
      o.enableAutoPerformanceTracing = true;
    },
    appRunner: () {},
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  // Statusleiste freundlich
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

  runApp(
    ProviderScope(
      overrides: [prefsProvider.overrideWithValue(prefs)],
      child: const NaturkindAppBootstrap(),
    ),
  );
}

class NaturkindAppBootstrap extends ConsumerStatefulWidget {
  const NaturkindAppBootstrap({super.key});
  @override
  ConsumerState<NaturkindAppBootstrap> createState() =>
      _NaturkindAppBootstrapState();
}

class _NaturkindAppBootstrapState extends ConsumerState<NaturkindAppBootstrap> {

  @override
  void initState() {
    super.initState();
    unawaited(_lateInit());
  }

  Future<void> _lateInit() async {
    await _initSentryIfAllowed(ref);
    await _initFirebaseIfAllowed(ref);
    // Wenn Nutzer Push in den Einstellungen/Consent aktiviert, sofort FCM initialisieren
    ref.listen<bool>(consentPushProvider, (prev, next) {
      if (next == true && prev != true) {
        unawaited(_initFirebaseIfAllowed(ref));
      }
    });
    // Wenn Nutzer Sentry-Consent erteilt, Sentry initialisieren bzw. schließen
    ref.listen<bool>(consentAnalyticsProvider, (prev, next) async {
      if (next == true && prev != true) {
        await _initSentryIfAllowed(ref);
      } else if (next == false && prev == true) {
        await Sentry.close();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(appRouterProvider); // deine go_router factory
    const seed = Colors.green;
    const lightBg = Color(0xFFF6FAF6);
    final theme = ThemeData(
      useMaterial3: true,
      colorSchemeSeed: seed,
      scaffoldBackgroundColor: lightBg,
      cardTheme: CardThemeData(
        elevation: 2,
        shadowColor: Colors.black.withValues(alpha: 0.06),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      appBarTheme: const AppBarTheme(centerTitle: false),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
      ),
      chipTheme: const ChipThemeData(
        shape: StadiumBorder(),
        selectedColor: Color(0xFFBDE0C2),
        secondarySelectedColor: Color(0xFFBDE0C2),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
    );

    return MaterialApp.router(
      title: 'Naturkind',
      routerConfig: router,
      theme: theme,
      debugShowCheckedModeBanner: false,
    );
  }
}
