import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:cinemapedia/presentation/views/views.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
  // State-Preserving
  StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          HomeScreen(child: navigationShell),
      branches: [
        StatefulShellBranch(routes: <RouteBase>[
          GoRoute(
              path: '/',
              builder: (context, state) {
                return const HomeView();
              })
        ]),
        StatefulShellBranch(routes: <RouteBase>[
          GoRoute(
            path: '/favorites',
            builder: (context, state) {
              return const FavoritesViews();
            },
          )
        ]),
      ]),
  GoRoute(
    path: '/movie/:id',
    builder: (context, state) {
      final movieId = state.pathParameters['id'] ?? 'no-id';
      return MovieScreen(movieId: movieId);
    },
  ),
]);
