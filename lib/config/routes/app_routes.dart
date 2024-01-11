import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [

    // Home Screen
    GoRoute(
      path: '/',
      builder: (context, state) =>  const HomeScreen(),
    ),

  ]
);