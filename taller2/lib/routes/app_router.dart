import 'package:go_router/go_router.dart';
import '../screens/home_screen.dart';
import '../screens/upload_screen.dart';
import '../screens/summary_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/async_screen.dart';
import '../screens/timer_screen.dart';
import '../screens/isolate_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(path: '/upload', builder: (context, state) => const UploadScreen()),
    GoRoute(
        path: '/summary', builder: (context, state) => const SummaryScreen()),
    GoRoute(
        path: '/profile', builder: (context, state) => const ProfileScreen()),
    GoRoute(path: '/async', builder: (context, state) => const AsyncScreen()),
    GoRoute(path: '/timer', builder: (context, state) => const TimerScreen()),
    GoRoute(
        path: '/isolate', builder: (context, state) => const IsolateScreen()),
  ],
);
