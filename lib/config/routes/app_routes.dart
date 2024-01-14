import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
  // Home Screen
  GoRoute(path: '/', builder: (context, state) => const HomeScreen(), routes: [
    GoRoute(
      path: 'movie/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? 'no-id';
        return MovieScreen(movieId: id);
      },
    ),
  ]),
]);
