import 'package:go_router/go_router.dart';
import 'package:music_player/screens/home_screen.dart';
import 'package:music_player/screens/music_player_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/music-player',
  routes: [
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen()
    ),
    GoRoute(
      path: '/music-player',
      builder: (context, state) => const MusicPlayerScreen()
    ),
  ]
);