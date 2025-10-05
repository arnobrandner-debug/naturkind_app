import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'features/consent/consent_page.dart';
import 'features/kids/kids_guard.dart';
import 'features/kids/kids_page.dart';
import 'features/kids/pages/kids_home_page.dart';
import 'features/kids/pages/kids_list_page.dart';
import 'features/kids/pages/kids_detail_page.dart';
import 'features/kids/pages/kids_stickers_page.dart';
import 'features/parents/parents_page.dart';
import 'features/settings/settings_page.dart';
import 'features/feed/feed_page.dart';
import 'features/article/article_page.dart';
import 'features/epaper/epaper_page.dart';
import 'features/auth/steady_gate_page.dart';
import 'features/onboarding/onboarding_page.dart';
// main.dart wird hier nicht benötigt

GoRouter buildRouter(Ref ref) {
  return GoRouter(
    // ignore: prefer_const_constructors
    refreshListenable: GoRouterRefreshStream(Stream.empty()), // optional
    redirect: kidsRedirect(ref), // Kids-Redirect aktiv
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const FeedPage(),
        routes: [
          GoRoute(
            path: 'article/:id',
            builder: (context, state) {
              final id = int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
              return ArticlePage(postId: id);
            },
          ),
          GoRoute(
            path: 'epaper',
            builder: (context, state) => const EpaperPage(
              pdfUrl: 'https://example.com/epaper.pdf',
              title: 'Naturkind E-Paper',
            ),
          ),
          GoRoute(
            path: 'plus',
            builder: (context, state) => const SteadyGatePage(),
          ),
        ],
      ),
      GoRoute(path: '/kids', builder: (c, s) => const KidsPage()),
      // Kids v1 routes (stubs)
      GoRoute(path: '/kids', builder: (c, s) => const KidsHomePage()),
      GoRoute(
        path: '/kids/:tag',
        builder: (c, s) => KidsListPage(tag: s.pathParameters['tag'] ?? ''),
      ),
      GoRoute(
        path: '/kids/item/:id',
        builder: (c, s) => KidsDetailPage(id: s.pathParameters['id'] ?? '0'),
      ),
      GoRoute(path: '/kids/stickers', builder: (c, s) => const KidsStickersPage()),
      GoRoute(path: '/parents', builder: (c, s) => const ParentsPage()),
      GoRoute(path: '/settings', builder: (c, s) => const SettingsPage()),
      GoRoute(path: '/consent', builder: (c, s) => const ConsentPage()),
      GoRoute(path: '/onboarding', builder: (c, s) => const OnboardingPage()),
    ],
  );
}

// Lightweight replacement for the helper that used to ship with go_router.
// Bridges a Stream to a Listenable so GoRouter can refresh on events.
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

// Optionaler Provider, falls du den Router injizieren möchtest
final appRouterProvider = Provider<GoRouter>((ref) => buildRouter(ref));
