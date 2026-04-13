import 'package:go_router/go_router.dart';
import '../screens/home_screen.dart';
import '../screens/upload_screen.dart';
import '../screens/summary_screen.dart';
import '../screens/profile_screen.dart';

// Archivo central de rutas — equivalente al archivo de rutas en go_router
final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(path: '/upload', builder: (context, state) => const UploadScreen()),
    GoRoute(
      path: '/summary',
      builder: (context, state) => const SummaryScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
  ],
);
