import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomNavigationBar extends ConsumerWidget {
  const CustomNavigationBar({super.key});

  void onItemTapped(BuildContext context, int index) {

    switch(index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/categories');
        break;
      case 2:
        context.go('/favorites');
        break;
      default:
        context.go('/');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final index = ref.watch(indexNavbarProvider);

    return BottomNavigationBar(
      currentIndex: index,
      elevation: 0,
      onTap: (value) {
        ref.read(indexNavbarProvider.notifier).state = value;
        onItemTapped(context, value);
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_max_outlined), label: 'Inicio'),
        BottomNavigationBarItem(icon: Icon(Icons.category_outlined), label: 'Categorias'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite_outline_outlined), label: 'Favoritos'),
      ],
    );
  }
}