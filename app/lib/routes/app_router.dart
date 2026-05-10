import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../screens/upload_screen.dart';
import '../screens/summary_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/local_storage_screen.dart';
import '../services/storage_service.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  redirect: (BuildContext context, GoRouterState state) async {
    final isLoggedIn = await StorageService.isLoggedIn();
    final isAuthRoute = state.matchedLocation == '/login' ||
        state.matchedLocation == '/register';

    if (!isLoggedIn && !isAuthRoute) return '/login';
    if (isLoggedIn && isAuthRoute) return '/';
    return null;
  },
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/upload/:tipo',
      builder: (context, state) {
        final tipo = state.pathParameters['tipo'] ?? 'texto';
        return UploadScreen(tipo: tipo);
      },
    ),
    GoRoute(
      path: '/summary',
      builder: (context, state) {
        final resumen = state.extra as String? ?? '';
        return SummaryScreen(resumen: resumen);
      },
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/storage',
      builder: (context, state) => const LocalStorageScreen(),
    ),
  ],
);
