import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/sample/presentation/screens/sample_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SampleScreen()),
    ],
    errorBuilder: (context, state) =>
        const Scaffold(body: Center(child: Text('Something Error'))),
  );
}
